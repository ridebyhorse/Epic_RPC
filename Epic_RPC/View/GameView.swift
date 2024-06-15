//
//  GameView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

enum GameMode {
    case pc
    case user
}

class GameView: UIView {
    
    ///После выбора жеста получаем результат раунда
    var onChoiceMade: ((UIImage, UIImage) -> Bool?)?
    
    ///Возвращает рандомный жест в игре для pc
    var getRandomGesture: (() -> UIImage)?
    
    var stopTimer: (() -> Void)?
    
    private let gameMode: GameMode
    private var userSwitched = false
    private var userChoice = UIImage()
    private let background = UIImageView()
    private let mainLabel = UILabel()
    private let userHand = UIImageView()
    private let pcHand = UIImageView()
    private let blood = UIImageView()
    private let rockButton = UIButton()
    private let paperButton = UIButton()
    private let scissorsButton = UIButton()
    private let changeUserButton = UIButton()
    private let timerProgress = UIProgressView()
    private let countDownLabel = UILabel()
    private let userAvatar = UIImageView()
    private let pcAvatar = UIImageView()
    private let scoreProgressUser = UIProgressView()
    private let scoreProgressPc = UIProgressView()
    private let scoreProgressSeparator = UIView()

    init(gameMode: GameMode) {
        self.gameMode = gameMode
        super.init(frame: .zero)
        setupUI()
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
        
        blood.image = .blood
        blood.alpha = 0
        blood.contentMode = .scaleAspectFit
        
        rockButton.setImage(.buttonGameStone, for: .normal)
        rockButton.tag = 0
        rockButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        paperButton.setImage(.buttonGamePaper, for: .normal)
        paperButton.tag = 1
        paperButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        scissorsButton.setImage(.buttonGameScissors, for: .normal)
        scissorsButton.tag = 2
        scissorsButton.addTarget(self, action: #selector(madeChoice), for: .touchUpInside)
        
        changeUserButton.setImage(.buttonGameSwitchPlayer, for: .normal)
        changeUserButton.addTarget(self, action: #selector(changeUserTapped), for: .touchUpInside)
        
        timerProgress.trackTintColor = .deepBlueGame
        timerProgress.progressTintColor = .greenGame
        timerProgress.progressViewStyle = .bar
        timerProgress.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        countDownLabel.font = .custom(font: .medium, size: 12)
        countDownLabel.textColor = .white
        
        userAvatar.contentMode = .scaleAspectFit
        
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
        addSubview(blood)
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
            blood.centerXAnchor.constraint(equalTo: centerXAnchor),
            blood.centerYAnchor.constraint(equalTo: centerYAnchor),
            blood.widthAnchor.constraint(equalToConstant: 100),
            blood.heightAnchor.constraint(equalToConstant: 100),
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
        
        if gameMode == .user {
            changeUserButton.translatesAutoresizingMaskIntoConstraints = false
            addSubviews(changeUserButton)
            NSLayoutConstraint.activate([
                changeUserButton.widthAnchor.constraint(equalToConstant: 100),
                changeUserButton.heightAnchor.constraint(equalToConstant: 60),
                changeUserButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                changeUserButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            changeUserButton.isEnabled = false
        }
        
        animateHands()
    }
    
    func setupPlayerAvatar(avatar: String?) {
        guard let avatar else {
            userAvatar.image = .avatarUser
            return
        }
        userAvatar.image = UIImage(named: avatar)
    }
    
    func setupSecondPlayerAvatar(avatar: String?) {
        guard let avatar else {
            pcAvatar.image = .avatarPc
            return
        }
        pcAvatar.image = UIImage(named: avatar)
    }
    
    func updateTimeLabel(text : String) {
        countDownLabel.text = text
    }
    
    func updateTimeProgress(on count: Float) {
        timerProgress.progress += count
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
    
    func restartRound(seconds: RoundTime) {
        switch seconds {
        case .s30:
            countDownLabel.text = "0:30"
        case .s60:
            countDownLabel.text = "1:00"
        }
        timerProgress.progress = 0
        userHand.image = .maleHand
        pcHand.image = .femaleHand
        setupMainLabel(text: "FIGHT")
        animateHands()
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
    
    private func playWithUser(userTag: Int) {
        if userSwitched {
            switch userTag {
            case 0:
                pcHand.image = .femaleHandRock
            case 1:
                pcHand.image = .femaleHandPaper
            default:
                pcHand.image = .femaleHandScissors
            }
            userHand.image = userChoice
            guard let userImage = userHand.image else { return }
            guard let pcImage = pcHand.image else { return }
            applyRoundResult(onChoiceMade?(userImage, pcImage))
            animateHandsClapping(completion: {
                self.rockButton.isEnabled = true
                self.paperButton.isEnabled = true
                self.scissorsButton.isEnabled = true
            })
            userSwitched.toggle()
        } else {
            switch userTag {
            case 0:
                userChoice = .maleHandRock
            case 1:
                userChoice = .maleHandPaper
            default:
                userChoice = .maleHandScissors
            }
            
            userSwitched.toggle()
        }
    }
    
    private func playWithPc(userTag: Int) {
        switch userTag {
        case 0:
            userHand.image = .maleHandRock
        case 1:
            userHand.image = .maleHandPaper
        default:
            userHand.image = .maleHandScissors
        }
        pcHand.image = getRandomGesture?()
        guard let userImage = userHand.image else { return }
        guard let pcImage = pcHand.image else { return }
        applyRoundResult(onChoiceMade?(userImage, pcImage))
        animateHandsClapping(completion: {
            self.rockButton.isEnabled = true
            self.paperButton.isEnabled = true
            self.scissorsButton.isEnabled = true
        })
    }
    
    @objc private func madeChoice(_ sender: UIButton) {
        sender.layer.cornerRadius = sender.bounds.width / 2
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.yellowGame.cgColor
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        if gameMode == .pc {
            stopTimer?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                sender.layer.cornerRadius = 0
                sender.layer.borderWidth = 0
                sender.layer.borderColor = nil
                self?.playWithPc(userTag: sender.tag)
            }
        } else {
            if userSwitched {
                stopTimer?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                    sender.layer.cornerRadius = 0
                    sender.layer.borderWidth = 0
                    sender.layer.borderColor = nil
                    self?.playWithUser(userTag: sender.tag)
                }
            } else {
                changeUserButton.isEnabled = true
                playWithUser(userTag: sender.tag)
            }
        }
    }
    
    @objc private func changeUserTapped(_ sender: UIButton) {
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorsButton.isEnabled = true
        for button in [rockButton, paperButton, scissorsButton] {
            button.layer.cornerRadius = 0
            button.layer.borderWidth = 0
            button.layer.borderColor = nil
        }
        changeUserButton.isEnabled = false
    }
}

// MARK: - Animation
private extension GameView {
    func animateHands() {
        userHand.transform = CGAffineTransform.identity
        pcHand.transform = CGAffineTransform.identity
        
        let scaledTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.userHand.transform = scaledTransform
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            self.pcHand.transform = scaledTransform
        }, completion: nil)
    }
    
    func animateHandsClapping(completion: @escaping () -> Void) {
        let originalTransform = userHand.transform
        let scaledTransform = originalTransform.scaledBy(x: 1.1, y: 1.3)
        let rotation = CGAffineTransform(rotationAngle: -10 * .pi / 180)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.autoreverse, .beginFromCurrentState], animations: {
            self.userHand.transform = scaledTransform.concatenating(rotation)
            self.pcHand.transform = scaledTransform.concatenating(rotation)
        }, completion: { _ in
            self.userHand.transform = originalTransform
            self.pcHand.transform = originalTransform
        })
        
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [.curveEaseIn], animations: {
            self.blood.alpha = 1
            self.blood.transform = CGAffineTransform(scaleX: 3, y: 3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0.0, options: [.curveEaseIn], animations: {
                self.blood.alpha = 0
                self.blood.transform = CGAffineTransform.identity
            }, completion: nil)
        })
        completion()
    }
}
