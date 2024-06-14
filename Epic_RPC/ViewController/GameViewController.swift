//
//  GameViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit
import AVFAudio

class GameViewController: UIViewController {
    
    private enum TimerAction {
        case start
        case pause
        case `continue`
        case stop
    }
    
    private let game = Game()
    private let gameView = GameView()
    private var timer = Timer()
    private var musicPlayer = AVAudioPlayer()
    private var soundPlayer = AVAudioPlayer()
    
    private let secondsTotal: Float = 30.0
    private var secondsCount = 30
    private var userScore = 0 {
            didSet {
                if userScore == 3 {
                    goToResults(true)
                } else {
                    restartRound()
                }
            }
    }
    private var pcScore = 0 {
        didSet {
            if pcScore == 3 {
                goToResults(false)
            } else {
                restartRound()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPlayers()
        setTimer(action: .start)
        
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
        gameView.setupPlayerAvatar(avatar: Game.currentSettings.firstPlayer.image)
        gameView.setupSecondPlayerAvatar(avatar: Game.currentSettings.secondPlayer?.image)
        view = gameView
    }
    
    private func setTimer(action: TimerAction) {
        switch action {
        case .start:
            secondsCount = Int(secondsTotal)
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .pause:
            timer.invalidate()
        case .continue:
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .stop:
            timer.invalidate()
        }
    }
    
    private func goToResults(_ result: Bool) {
        navigationController?.pushViewController(ResultViewController(), animated: true)
        musicPlayer.stop()
    }
    
    private func calculateWin(_ userImage: UIImage, _ pcImage: UIImage) -> Bool? {
        setTimer(action: .pause)
        let result = game.calculateWin(user: getGestureForImage(userImage), pc: getGestureForImage(pcImage))
        if result == true {
            userScore += 1
        } else if result == false {
            pcScore += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.soundPlayer.play()
        }
        return result
    }
    
    private func restartRound() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.setTimer(action: .start)
            self?.gameView.restartRound()
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
        let urlNusic = Bundle.main.url(forResource: "449640__cnupoc__main-theme", withExtension: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: urlNusic!)
        musicPlayer.numberOfLoops =  -1
        musicPlayer.play()
        
        let urlSound = Bundle.main.url(forResource: "573376__johnloser__cyber-punch-01", withExtension: "wav")
        soundPlayer = try! AVAudioPlayer(contentsOf: urlSound!)
    }
    
    @objc private func updateCountDown(_ sender: Timer) {
        if secondsCount > 0 {
            if secondsTotal != Float(secondsCount) {
                gameView.updateTimeProgress(on: 1.0 / secondsTotal)
            }
            let minutesCount = String(secondsCount / 60)
            if secondsCount < 10 {
                gameView.updateTimeLabel(text: minutesCount + ":0" + String(secondsCount))
            } else {
                gameView.updateTimeLabel(text: minutesCount + ":" + String(secondsCount))
            }
            secondsCount -= 1
        } else {
            setTimer(action: .stop)
            goToResults(false)
        }
    }

}
