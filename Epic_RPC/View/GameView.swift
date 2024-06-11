//
//  GameView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class GameView: UIView {

    ///Переход на экран Results по окончанию игры
    var finishGame: ((Bool) -> Void)?
    
    ///После выбора жеста получаем результат раунда
    var onChoiceMade: ((UIImage, UIImage) -> Bool?)?
    
    ///Возвращает рандомный жест в игре для pc
    var getRandomGesture: (() -> UIImage)?
    
    private enum TimerAction {
        case start
        case pause
        case `continue`
        case stop
    }
    
    private let secondsTotal: Float = 30.0
    private var secondsCount = 30
    private var timer = Timer()
    private let background = UIImageView()
    private let mainLabel = UILabel()
    private let userHand = UIImageView()
    private let pcHand = UIImageView()
    private let rockButton = UIButton()
    private let paperButton = UIButton()
    private let scissorsButton = UIButton()
    private let timerProgress = UIProgressView()
    private let countDownLabel = UILabel()
    private let userAvatar = UIImageView()
    private let pcAvatar = UIImageView()
    private let scoreProgressUser = UIProgressView()
    private let scoreProgressPc = UIProgressView()
    private let scoreProgressSeparator = UIView()

    init() {
        super.init(frame: .zero)
        setupUI()
        setTimer(action: .start)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timerProgress.layer.cornerRadius = 5
        timerProgress.clipsToBounds = true
    }
    
    private func setupUI() {
        background.image = .gameBg
        background.contentMode = .scaleAspectFill
        
        mainLabel.font = .custom(font: .bold, size: 56)
        mainLabel.textColor = .yellowGame
        setupMainLabel(text: "FIGHT")
        
        userHand.image = .maleHand
        userHand.contentMode = .scaleAspectFit
        
        pcHand.image = .femaleHand
        pcHand.contentMode = .scaleAspectFit
        
        rockButton.setImage(.buttonGameStone, for: .normal)
        rockButton.tag = 0
        rockButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        paperButton.setImage(.buttonGamePaper, for: .normal)
        paperButton.tag = 1
        paperButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        scissorsButton.setImage(.buttonGameScissors, for: .normal)
        scissorsButton.tag = 2
        scissorsButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        timerProgress.trackTintColor = .deepBlueGame
        timerProgress.progressTintColor = .greenGame
        timerProgress.progressViewStyle = .bar
        timerProgress.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        countDownLabel.font = .custom(font: .medium, size: 12)
        countDownLabel.textColor = .white
        
        userAvatar.image = .avatarUser
        userAvatar.contentMode = .scaleAspectFit
        
        pcAvatar.image = .avatarPc
        pcAvatar.contentMode = .scaleAspectFit
        
        scoreProgressUser.trackTintColor = .deepBlueGame
        scoreProgressUser.progressTintColor = .yellowGame
        scoreProgressUser.progressViewStyle = .bar
        scoreProgressUser.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        scoreProgressPc.trackTintColor = .deepBlueGame
        scoreProgressPc.progressTintColor = .redGame
        scoreProgressPc.progressViewStyle = .bar
        scoreProgressPc.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        scoreProgressSeparator.backgroundColor = .white
        
        addSubview(background)
        addSubview(mainLabel)
        addSubview(userHand)
        addSubview(pcHand)
        addSubview(rockButton)
        addSubview(paperButton)
        addSubview(scissorsButton)
        addSubview(timerProgress)
        addSubview(countDownLabel)
        addSubview(scoreProgressUser)
        addSubview(scoreProgressPc)
        addSubview(userAvatar)
        addSubview(pcAvatar)
        addSubview(scoreProgressSeparator)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userHand.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 80),
            userHand.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            userHand.topAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            pcHand.topAnchor.constraint(equalTo: topAnchor, constant: -80),
            pcHand.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            pcHand.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            paperButton.widthAnchor.constraint(equalToConstant: 80),
            paperButton.heightAnchor.constraint(equalTo: rockButton.widthAnchor),
            paperButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            rockButton.widthAnchor.constraint(equalTo: paperButton.widthAnchor),
            rockButton.heightAnchor.constraint(equalTo: rockButton.widthAnchor),
            rockButton.topAnchor.constraint(equalTo: paperButton.topAnchor, constant: 50),
            rockButton.trailingAnchor.constraint(equalTo: paperButton.leadingAnchor, constant: -16),
            scissorsButton.widthAnchor.constraint(equalTo: paperButton.widthAnchor),
            scissorsButton.heightAnchor.constraint(equalTo: scissorsButton.widthAnchor),
            scissorsButton.centerYAnchor.constraint(equalTo: rockButton.centerYAnchor),
            scissorsButton.leadingAnchor.constraint(equalTo: paperButton.trailingAnchor, constant: 16),
            timerProgress.widthAnchor.constraint(equalToConstant: 166),
            timerProgress.heightAnchor.constraint(equalToConstant: 10),
            timerProgress.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            timerProgress.centerYAnchor.constraint(equalTo: centerYAnchor),
            countDownLabel.topAnchor.constraint(equalTo: timerProgress.centerYAnchor, constant: 87),
            countDownLabel.centerXAnchor.constraint(equalTo: timerProgress.centerXAnchor),
            scoreProgressUser.widthAnchor.constraint(equalToConstant: 150),
            scoreProgressUser.heightAnchor.constraint(equalToConstant: 10),
            scoreProgressUser.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            scoreProgressUser.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 75),
            scoreProgressPc.widthAnchor.constraint(equalToConstant: 150),
            scoreProgressPc.heightAnchor.constraint(equalToConstant: 10),
            scoreProgressPc.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            scoreProgressPc.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -75),
            userAvatar.widthAnchor.constraint(equalToConstant: 36),
            userAvatar.heightAnchor.constraint(equalToConstant: 42),
            userAvatar.centerYAnchor.constraint(equalTo: scoreProgressUser.centerYAnchor, constant: 85),
            userAvatar.centerXAnchor.constraint(equalTo: scoreProgressUser.centerXAnchor),
            pcAvatar.widthAnchor.constraint(equalTo: userAvatar.widthAnchor),
            pcAvatar.heightAnchor.constraint(equalTo: userAvatar.heightAnchor),
            pcAvatar.centerYAnchor.constraint(equalTo: scoreProgressPc.centerYAnchor, constant: -85),
            pcAvatar.centerXAnchor.constraint(equalTo: scoreProgressPc.centerXAnchor, constant: -3),
            scoreProgressSeparator.widthAnchor.constraint(equalToConstant: 18),
            scoreProgressSeparator.heightAnchor.constraint(equalToConstant: 1),
            scoreProgressSeparator.centerYAnchor.constraint(equalTo: scoreProgressUser.centerYAnchor, constant: -75),
            scoreProgressSeparator.centerXAnchor.constraint(equalTo: scoreProgressUser.centerXAnchor)
        ])
    }
    
    private func setTimer(action: TimerAction) {
        switch action {
        case .start:
            secondsCount = Int(secondsTotal)
            timerProgress.progress = 0
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .pause:
            timer.invalidate()
        case .continue:
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        case .stop:
            timer.invalidate()
            countDownLabel.text = "0:00"
            timerProgress.progress = 0
        }
    }

    
    private func applyRoundResult(_ result: Bool?) {
        switch result {
        case true:
            setupMainLabel(text: "WIN")
            scoreProgressUser.progress += 1.0 / 3
        case false:
            setupMainLabel(text: "LOSE")
            scoreProgressPc.progress += 1.0 / 3
        default:
            setupMainLabel(text: "DRAW")
        }
    }
    
    private func restartRound() {
        if scoreProgressUser.progress > 0.9 || scoreProgressPc.progress > 0.9 {
            if scoreProgressUser.progress > 0.9 {
                finishGame?(true)
            } else {
                finishGame?(false)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.userHand.image = .maleHand
                self?.pcHand.image = .femaleHand
                self?.setTimer(action: .start)
                self?.setupMainLabel(text: "FIGHT")
            }
        }
    }
    
    private func setupMainLabel(text: String) {
        mainLabel.alpha = 1
        mainLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            UIView.animate(withDuration: 1.5) {
                self?.mainLabel.alpha = 0
            }
        }
    }
    
    @objc private func madeChoice(_ sender: UIButton) {
        setTimer(action: .pause)
        sender.layer.cornerRadius = sender.bounds.width / 2
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.yellowGame.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            switch sender.tag {
            case 0:
                print("chose rock")
                self?.userHand.image = .maleHandRock
            case 1:
                print("chose paper")
                self?.userHand.image = .maleHandPaper
            default:
                print("chose scissors")
                self?.userHand.image = .maleHandScissors
            }
            self?.pcHand.image = self?.getRandomGesture?()
            sender.layer.cornerRadius = 0
            sender.layer.borderWidth = 0
            sender.layer.borderColor = nil
            guard let userImage = self?.userHand.image else { return }
            guard let pcImage = self?.pcHand.image else { return }
            self?.applyRoundResult(self?.onChoiceMade?(userImage, pcImage))
            self?.restartRound()
        }
    }
    
    @objc private func updateCountDown(_ sender: Timer) {
        if secondsTotal != Float(secondsCount) {
            timerProgress.progress += 1.0 / secondsTotal
        }
        if secondsCount > 0 {
            let minutesCount = String(secondsCount / 60)
            if secondsCount < 10 {
                countDownLabel.text = minutesCount + ":0" + String(secondsCount)
            } else {
                countDownLabel.text = minutesCount + ":" + String(secondsCount)
            }
            secondsCount -= 1
        } else {
            setTimer(action: .stop)
            finishGame?(false)
        }
    }
}
