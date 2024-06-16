//
//  SettingsView.swift
//  Epic_RPC
//
//  Created by Andrey Zavershinskiy on 14.06.2024.
//

import UIKit

final class SettingsView: UIView {

//	private var friendPlayerIsHide = false
    
    var onClose: (() -> Settings)?
    
    private var time: RoundTime = .s30
    private var music: Music = .mainTheme
    private var gameMode: GameMode = .pc

	//MARK: - UI Elements

	//top View
	private let topView = UIView()

	private let gameTimeLabel = UILabel()

	private let setGameTime30cec = UIButton()
	private let setGameTime60cec = UIButton()

	//bottom View
	private let bottomView = UIView()
	private let buttonBackground1 = UIView()
	private let buttonBackground2 = UIView()

	private let backgroundMusicLabel = UILabel()
	private let gameModeLabel = UILabel()

	private let setMusicButton = UIButton()
	private let switchGameMode = UISwitch()

	private let buttonArrowImage = UIImage(systemName: "chevron.right")

	//players
//	let firstPlayerImage = UIImageView()
//	let secondPlayerImage = UIImageView()
//
//	let firstPlayerNameButton = UIButton()
//	let secondPlayerNameButton = UIButton()

	//MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
        onClose = { self.getSettings() }
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Extensions
private extension SettingsView {

	//MARK: -  Setup UI

	private func setupViews() {
		backgroundColor = .appBackground

		//top View
		topView.layer.borderWidth = 0.5
		topView.layer.borderColor = UIColor.appBorder.cgColor
		topView.layer.cornerRadius = 20
		topView.layer.masksToBounds = true

		gameTimeLabel.text = "Время игры".uppercased()
		gameTimeLabel.font = .custom(font: .regular, size: 20)
		gameTimeLabel.textAlignment = .center

		setGameTime30cec.setTitle("30 sec", for: .normal)
		setGameTime30cec.titleLabel?.font = .custom(font: .medium, size: 16)
        if Game.currentSettings.roundTime == .s30 {
            setGameTime30cec.backgroundColor = .greenGame
        } else {
            setGameTime30cec.backgroundColor = .buttonOrange
        }
		
		setGameTime30cec.layer.cornerRadius = 15
        setGameTime30cec.tag = 0
        setGameTime30cec.addTarget(self, action: #selector(choseTime), for: .touchUpInside)

		setGameTime60cec.setTitle("60 sec", for: .normal)
		setGameTime60cec.titleLabel?.font = setGameTime30cec.titleLabel?.font
        if Game.currentSettings.roundTime == .s60 {
            setGameTime60cec.backgroundColor = .greenGame
        } else {
            setGameTime60cec.backgroundColor = .buttonOrange
        }
		setGameTime60cec.layer.cornerRadius = setGameTime30cec.layer.cornerRadius
        setGameTime60cec.tag = 1
        setGameTime60cec.addTarget(self, action: #selector(choseTime), for: .touchUpInside)

		addSubview(topView)
		topView.addSubview(gameTimeLabel)
		topView.addSubview(setGameTime30cec)
		topView.addSubview(setGameTime60cec)

		//bottom View
		bottomView.layer.borderWidth = topView.layer.borderWidth
		bottomView.layer.borderColor = topView.layer.borderColor
		bottomView.layer.cornerRadius = topView.layer.cornerRadius
		bottomView.layer.masksToBounds = topView.layer.masksToBounds

		buttonBackground1.backgroundColor = .buttonOrange
		buttonBackground1.layer.cornerRadius = 15
		buttonBackground1.layer.masksToBounds = true
		buttonBackground2.backgroundColor = buttonBackground1.backgroundColor
		buttonBackground2.layer.cornerRadius = buttonBackground1.layer.cornerRadius
		buttonBackground2.layer.masksToBounds = buttonBackground1.layer.masksToBounds

		setMusicButton.tintColor = .white
        setMusicButton.setTitle(Game.currentSettings.music, for: .normal) // test
		setMusicButton.titleLabel?.font = .custom(font: .regular, size: 14)
		setMusicButton.setImage(buttonArrowImage, for: .normal)
		setMusicButton.semanticContentAttribute = .forceRightToLeft
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Main Theme", image: nil, handler: { (_) in
                    self.setMusicButton.setTitle("Main Theme", for: .normal)
                    self.music = .mainTheme
                }),
                UIAction(title: "Bass Theme", image: nil, handler: { (_) in
                    self.setMusicButton.setTitle("Bass Theme", for: .normal)
                    self.music = .bassTheme
                }),
                UIAction(title: "Tense Theme", image: nil, handler: { (_) in
                    self.setMusicButton.setTitle("Tense Theme", for: .normal)
                    self.music = .tenseTheme
                })
            ]
        }
        setMusicButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        setMusicButton.showsMenuAsPrimaryAction = true

		backgroundMusicLabel.text = "Фоновая музыка"
		backgroundMusicLabel.font = .custom(font: .bold, size: 16)
		backgroundMusicLabel.textColor = .white
		backgroundMusicLabel.textAlignment = .left

		gameModeLabel.text = "Игра с другом"
		gameModeLabel.font = backgroundMusicLabel.font
		gameModeLabel.textColor = backgroundMusicLabel.textColor
		gameModeLabel.textAlignment = backgroundMusicLabel.textAlignment
        
        switchGameMode.onTintColor = .greenGame
        switchGameMode.addTarget(self, action: #selector(switchedMode), for: .valueChanged)
        if Game.currentSettings.secondPlayer == nil {
            switchGameMode.isOn = false
        } else {
            switchGameMode.isOn = true
        }

		addSubview(bottomView)
		bottomView.addSubview(buttonBackground1)
		bottomView.addSubview(buttonBackground2)
		buttonBackground1.addSubview(backgroundMusicLabel)
		buttonBackground1.addSubview(setMusicButton)
		buttonBackground2.addSubview(gameModeLabel)
		buttonBackground2.addSubview(switchGameMode)

		//players
//		firstPlayerImage.image = .avatarUser
//		secondPlayerImage.image = .avatarPc
//
//		firstPlayerNameButton.setTitle("Player 1", for: .normal)
//		firstPlayerNameButton.titleLabel?.font = .custom(font: .bold, size: 16)
//		firstPlayerNameButton.setTitleColor(.systemRed, for: .normal) // test
//		firstPlayerNameButton.layer.cornerRadius = 20
//		firstPlayerNameButton.layer.borderWidth = 1
//		firstPlayerNameButton.layer.borderColor = UIColor.systemGray4.cgColor
//
//		secondPlayerNameButton.setTitle("Player 2", for: .normal)
//		secondPlayerNameButton.titleLabel?.font = firstPlayerNameButton.titleLabel?.font
//		secondPlayerNameButton.setTitleColor(.systemCyan, for: .normal) // test
//		secondPlayerNameButton.layer.cornerRadius = firstPlayerNameButton.layer.cornerRadius
//		secondPlayerNameButton.layer.borderWidth = firstPlayerNameButton.layer.borderWidth
//		secondPlayerNameButton.layer.borderColor = firstPlayerNameButton.layer.borderColor

//		addSubview(firstPlayerImage)
//		addSubview(secondPlayerImage)
//		addSubview(firstPlayerNameButton)
//		addSubview(secondPlayerNameButton)

		setupConstraints()
	}

	//MARK: -  Constraints

	private func setupConstraints() {
		topView.translatesAutoresizingMaskIntoConstraints = false
		bottomView.translatesAutoresizingMaskIntoConstraints = false
		gameTimeLabel.translatesAutoresizingMaskIntoConstraints = false
		buttonBackground1.translatesAutoresizingMaskIntoConstraints = false
		buttonBackground2.translatesAutoresizingMaskIntoConstraints = false
		setGameTime30cec.translatesAutoresizingMaskIntoConstraints = false
		setGameTime60cec.translatesAutoresizingMaskIntoConstraints = false
		backgroundMusicLabel.translatesAutoresizingMaskIntoConstraints = false
		gameModeLabel.translatesAutoresizingMaskIntoConstraints = false
		setMusicButton.translatesAutoresizingMaskIntoConstraints = false
		switchGameMode.translatesAutoresizingMaskIntoConstraints = false
//		firstPlayerImage.translatesAutoresizingMaskIntoConstraints = false
//		secondPlayerImage.translatesAutoresizingMaskIntoConstraints = false
//		firstPlayerNameButton.translatesAutoresizingMaskIntoConstraints = false
//		secondPlayerNameButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			//top
			topView.topAnchor.constraint(equalTo: topAnchor, constant: 106),
			topView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			topView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

			gameTimeLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
			gameTimeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
			gameTimeLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),

			setGameTime30cec.topAnchor.constraint(equalTo: gameTimeLabel.bottomAnchor, constant: 20),
			setGameTime30cec.heightAnchor.constraint(equalToConstant: 40),
			setGameTime30cec.widthAnchor.constraint(equalToConstant: 135),
			setGameTime30cec.leadingAnchor.constraint(equalTo: gameTimeLabel.leadingAnchor),
			setGameTime30cec.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),

			setGameTime60cec.topAnchor.constraint(equalTo: setGameTime30cec.topAnchor),
			setGameTime60cec.widthAnchor.constraint(equalTo: setGameTime30cec.widthAnchor),
			setGameTime60cec.trailingAnchor.constraint(equalTo: gameTimeLabel.trailingAnchor),
			setGameTime60cec.bottomAnchor.constraint(equalTo: setGameTime30cec.bottomAnchor),

			//bottom
			bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 22),
			bottomView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
			bottomView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),

			buttonBackground1.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
			buttonBackground1.leadingAnchor.constraint(equalTo: setGameTime30cec.leadingAnchor),
			buttonBackground1.trailingAnchor.constraint(equalTo: setGameTime60cec.trailingAnchor),
			buttonBackground1.heightAnchor.constraint(equalToConstant: 50),

			buttonBackground2.topAnchor.constraint(equalTo: buttonBackground1.bottomAnchor, constant: 20),
			buttonBackground2.leadingAnchor.constraint(equalTo: buttonBackground1.leadingAnchor),
			buttonBackground2.trailingAnchor.constraint(equalTo: buttonBackground1.trailingAnchor),
			buttonBackground2.heightAnchor.constraint(equalTo: buttonBackground1.heightAnchor),
			buttonBackground2.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20),

			backgroundMusicLabel.leadingAnchor.constraint(equalTo: buttonBackground1.leadingAnchor, constant: 20),
			backgroundMusicLabel.centerYAnchor.constraint(equalTo: buttonBackground1.centerYAnchor),

			setMusicButton.trailingAnchor.constraint(equalTo: buttonBackground1.trailingAnchor, constant: -20),
			setMusicButton.centerYAnchor.constraint(equalTo: buttonBackground1.centerYAnchor),

			gameModeLabel.leadingAnchor.constraint(equalTo: backgroundMusicLabel.leadingAnchor),
			gameModeLabel.centerYAnchor.constraint(equalTo: buttonBackground2.centerYAnchor),

			switchGameMode.trailingAnchor.constraint(equalTo: setMusicButton.trailingAnchor),
			switchGameMode.centerYAnchor.constraint(equalTo: buttonBackground2.centerYAnchor)

//			firstPlayerImage.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 22),
//			firstPlayerImage.leadingAnchor.constraint(equalTo: buttonBackground1.leadingAnchor),
//			firstPlayerImage.heightAnchor.constraint(equalToConstant: 46),
//			firstPlayerImage.widthAnchor.constraint(equalTo: firstPlayerImage.heightAnchor),
//
//			secondPlayerImage.topAnchor.constraint(equalTo: firstPlayerImage.bottomAnchor, constant: 22),
//			secondPlayerImage.leadingAnchor.constraint(equalTo: buttonBackground1.leadingAnchor),
//			secondPlayerImage.heightAnchor.constraint(equalToConstant: 46),
//			secondPlayerImage.widthAnchor.constraint(equalTo: secondPlayerImage.heightAnchor),
//
//			firstPlayerNameButton.topAnchor.constraint(equalTo: firstPlayerImage.topAnchor),
//			firstPlayerNameButton.leadingAnchor.constraint(equalTo: firstPlayerImage.trailingAnchor, constant: 7),
//			firstPlayerNameButton.trailingAnchor.constraint(equalTo: buttonBackground2.trailingAnchor),
//			firstPlayerNameButton.bottomAnchor.constraint(equalTo: firstPlayerImage.bottomAnchor),
//
//			secondPlayerNameButton.topAnchor.constraint(equalTo: secondPlayerImage.topAnchor),
//			secondPlayerNameButton.leadingAnchor.constraint(equalTo: firstPlayerImage.trailingAnchor, constant: 7),
//			secondPlayerNameButton.trailingAnchor.constraint(equalTo: buttonBackground2.trailingAnchor),
//			secondPlayerNameButton.bottomAnchor.constraint(equalTo: secondPlayerImage.bottomAnchor),
		])
	}
    
    private func getSettings() -> Settings {
        let user = Game.currentSettings.firstPlayer
        let secondUser: Player?
        if gameMode == .user {
            secondUser = Player(image: "avatar_pc", name: "User2")
        } else {
            secondUser = nil
        }
        return Settings(firstPlayer: user, secondPlayer: secondUser, roundTime: time, music: music.rawValue)
    }
    
    @objc private func choseTime(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            setGameTime30cec.backgroundColor = .greenGame
            setGameTime60cec.backgroundColor = .buttonOrange
            time = .s30
        default:
            setGameTime30cec.backgroundColor = .buttonOrange
            setGameTime60cec.backgroundColor = .greenGame
            time = .s60
        }
        
    }
    
    @objc private func switchedMode(_ sender: UISwitch) {
        if sender.isOn {
            gameMode = .user
        } else {
            gameMode = .pc
        }
    }
    
}

//MARK: - Preview

import SwiftUI

struct SettingsViewProvider: PreviewProvider {
	static var previews: some View {
		ContainerView().ignoresSafeArea()
	}
	struct ContainerView: UIViewRepresentable {
		let view = SettingsView()

		func makeUIView(context: Context) -> some UIView {
			return view
		}
		func updateUIView(_ uiView: UIViewType, context: Context) { }
	}
}
