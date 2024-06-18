//
//  GameViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit
import AVFAudio
import RxSwift
import RxCocoa
import RxGesture

class GameViewController: UIViewController {
    
    private enum TimerAction {
        case start
        case `continue`
        case stop
    }
    private var pauseAtResult = false
    private let game = Game()
    private let gameView: GameView
    private var timer = Timer()
    private var musicPlayer = AVAudioPlayer()
    private var soundPlayer = AVAudioPlayer()
    private let navBar = NavBar()
        .title("Game")
        .leftButton(.back)
        .rightButton(.buttonGamePause)
    private let disposeBag = DisposeBag()
    private let secondsTotal: Float
    private var secondsCount: Int
    private var userScore = 0 {
        didSet {
            if userScore == 3 {
                goToResults(true)
            }
        }
    }
    private var pcScore = 0 {
        didSet {
            if pcScore == 3 {
                goToResults(false)
            }
        }
    }
    
    init() {
        let gameMode: GameMode
        if Game.currentSettings.secondPlayer == nil {
            gameMode = .pc
        } else {
            gameMode = .user
        }
        gameView = GameView(gameMode: gameMode)
        switch Game.currentSettings.roundTime {
        case .s30:
            secondsCount = 29
            secondsTotal = 30.0
        case .s60:
            secondsCount = 59
            secondsTotal = 60.0
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPlayers()
        setTimer(action: .start)
        setupBindings()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        gameView.onChoiceMade = { [weak self] in self?.calculateWin($0, $1) }
        gameView.getRandomGesture = { [weak self] in
            if let gesture = self?.getRandomGesture() {
                return gesture
            } else {
                return .femaleHandRock
            }
        }
        gameView.stopTimer = { [weak self] in self?.setTimer(action: .stop) }
        gameView.setupPlayerAvatar(avatar: Game.currentSettings.firstPlayer.image)
        gameView.setupSecondPlayerAvatar(avatar: Game.currentSettings.secondPlayer?.image)
        view = gameView
        gameView.restartRound(seconds: Int(secondsTotal))
        view.addSubviews(navBar)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setTimer(action: TimerAction) {
        switch action {
        case .start:
            secondsCount = Int(secondsTotal - 1.0)
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .continue:
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .stop:
            timer.invalidate()
        }
    }
    
    private func goToResults(_ result: Bool) {
        musicPlayer.stop()
        setTimer(action: .stop)
        StorageService.shared.updateUserStatistics(username: Game.currentSettings.firstPlayer.name, win: result)
        StorageService.shared.updateUserStatistics(username: Game.currentSettings.secondPlayer?.name ?? StorageService.shared.getPcPlayer().name, win: !result)
        if let settings = StorageService.shared.getLastSettings() {
            game.setupGameSettings(settings: settings)
        }
        let resultVC = ResultViewController(result: result, scorePlayer: userScore, pcPlayerScore: pcScore)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    private func calculateWin(_ userImage: UIImage, _ pcImage: UIImage) -> Bool? {
        
        let result = game.calculateWin(user: getGestureForImage(userImage), pc: getGestureForImage(pcImage))

        if result == true {
            userScore += 1
        } else if result == false {
            pcScore += 1
        }
        restartRound()
        soundPlayer.play()
        
        return result
    }
    
    private func restartRound() {
        if userScore < 3 && pcScore < 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                if self?.presentedViewController == nil {
                    self?.setTimer(action: .start)
                    self?.gameView.restartRound(seconds: Int(self?.secondsTotal ?? 30))
                } else {
                    self?.pauseAtResult = true
                }
            }
        } else {
            setTimer(action: .stop)
            soundPlayer.stop()
            musicPlayer.stop()
        }
    }
    
    private func getRandomGesture() -> UIImage {
        [.femaleHandRock, .femaleHandPaper, .femaleHandScissors][Int.random(in: 0..<3)]
    }
    
    private func getGestureForImage(_ image: UIImage) -> GameGesture {
        switch image {
        case .femaleHandRock:
            return .rock
        case .maleHandRock:
            return .rock
        case .femaleHandPaper:
            return .paper
        case .maleHandPaper:
            return .paper
        default:
            return .scissors
        }
    }
    
    private func setupPlayers() {
        let urlMusic: URL?
        if let music = Music(rawValue: Game.currentSettings.music ?? "Main Theme") {
            urlMusic = MusicManager.getMusicFor(music)
        } else {
            urlMusic = Bundle.main.url(forResource: "449640__cnupoc__main-theme", withExtension: "mp3")
        }
        
        musicPlayer = try! AVAudioPlayer(contentsOf: urlMusic!)
        musicPlayer.numberOfLoops =  -1
        musicPlayer.play()
        
        let urlSound = Bundle.main.url(forResource: "573376__johnloser__cyber-punch-01", withExtension: "wav")
        soundPlayer = try! AVAudioPlayer(contentsOf: urlSound!)
    }
    
    private func setupBindings() {
        navBar.onLeftButtonTap
            .bind(onNext: { [weak self] in
                self?.gotoStartVC()
            })
            .disposed(by: disposeBag)
        navBar.onRightButtonTap
            .bind(onNext: { [weak self] in
                self?.putOnPause()
                self?.present(PauseViewController(onHomeTap: {self?.gotoStartVC()}, onPlayTap: {self?.continueGame()}), animated: true)
                self?.navigationController?.navigationBar.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    private func gotoStartVC() {
        setTimer(action: .stop)
        musicPlayer.stop()
        soundPlayer.stop()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func putOnPause() {
        setTimer(action: .stop)
        musicPlayer.stop()
    }
    
    private func continueGame() {
        musicPlayer.play()
        if gameView.onPause {
            gameView.onPause = false
        } else {
            if pauseAtResult {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                    self?.setTimer(action: .start)
                    self?.gameView.restartRound(seconds: Int(self?.secondsTotal ?? 30.0))
                    self?.pauseAtResult = false
                }
            } else {
                setTimer(action: .continue)
            }
        }
    }
    
    @objc private func updateCountDown(_ sender: Timer) {
        if secondsCount > 0 {
            if secondsCount < 10 {
                gameView.updateTimeLabel(text: "0:0" + String(secondsCount))
            } else {
                gameView.updateTimeLabel(text: "0:" + String(secondsCount))
            }
            gameView.updateTimeProgress(on: 1.0 / (secondsTotal - 1.0))
            secondsCount -= 1
        } else {
            setTimer(action: .stop)
            goToResults(false)
        }
    }

}
