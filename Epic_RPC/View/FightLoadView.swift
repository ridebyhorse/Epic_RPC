//
//  FightLoadView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class FightLoadView: UIView {
    
    private let settings: Settings
    
    private let background = UIImageView()
    private let userImage = UIImageView()
    private let pcImage = UIImageView()
    private let victoriesLabelUser = UILabel()
    private let loseLabelUser = UILabel()
    private let victoriesLabelPc = UILabel()
    private let loseLabelPc = UILabel()
    private let userVictoriesCountLabel = UILabel()
    private let userLoseCountLabel = UILabel()
    private let pcVictoriesCountLabel = UILabel()
    private let pcLoseCountLabel = UILabel()
    private let vsLabel = UILabel()
    private let readyLabel = UILabel()
    
    init() {
        settings = Game.currentSettings
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background.image = .winBackground
        background.contentMode = .scaleAspectFill
        
        userImage.image = UIImage(named: settings.firstPlayer.image ?? "avatar_user")
        userImage.contentMode = .scaleAspectFit
        
        pcImage.image = UIImage(named: settings.secondPlayer?.image ?? "avatar_pc")
        pcImage.contentMode = .scaleAspectFit
        
        victoriesLabelUser.font = .custom(font: .bold, size: 22)
        victoriesLabelUser.textColor = .white
        victoriesLabelUser.textAlignment = .center
        victoriesLabelUser.text = "Victories/"
        
        loseLabelUser.font = .custom(font: .bold, size: 22)
        loseLabelUser.textColor = .white
        loseLabelUser.textAlignment = .center
        loseLabelUser.text = "Lose"
        
        victoriesLabelPc.font = .custom(font: .bold, size: 22)
        victoriesLabelPc.textColor = .white
        victoriesLabelPc.textAlignment = .center
        victoriesLabelPc.text = "Victories/"
        
        loseLabelPc.font = .custom(font: .bold, size: 22)
        loseLabelPc.textColor = .white
        loseLabelPc.textAlignment = .center
        loseLabelPc.text = "Lose"
        
        userVictoriesCountLabel.font = .custom(font: .bold, size: 22)
        userVictoriesCountLabel.textColor = .yellowGame
        userVictoriesCountLabel.text = "\(settings.firstPlayer.victories)"
        
        userLoseCountLabel.font = .custom(font: .bold, size: 22)
        userLoseCountLabel.textColor = .redGame
        userLoseCountLabel.text = "\(settings.firstPlayer.loses)"
        
        pcVictoriesCountLabel.font = .custom(font: .bold, size: 22)
        pcVictoriesCountLabel.textColor = .yellowGame
        pcVictoriesCountLabel.text = "\(settings.secondPlayer?.victories ?? StorageService.shared.getPcPlayer().victories)"
        
        pcLoseCountLabel.font = .custom(font: .bold, size: 22)
        pcLoseCountLabel.textColor = .redGame
        pcLoseCountLabel.text = "\(settings.secondPlayer?.loses ?? StorageService.shared.getPcPlayer().loses)"
        
        vsLabel.font = .custom(font: .bold, size: 56)
        vsLabel.textColor = .yellowGame
        vsLabel.text = "VS"
        
        readyLabel.font = .custom(font: .bold, size: 19)
        readyLabel.textColor = .yellowGame
        readyLabel.text = "Get ready..."
        
        let userVictoriesLabel = UIStackView(arrangedSubviews: [userVictoriesCountLabel, victoriesLabelUser])
        userVictoriesLabel.axis = .horizontal
        userVictoriesLabel.spacing = 6
        
        let userLoseLabel = UIStackView(arrangedSubviews: [userLoseCountLabel, loseLabelUser])
        userLoseLabel.axis = .horizontal
        userLoseLabel.spacing = 6
        
        let pcVictoriesLabel = UIStackView(arrangedSubviews: [pcVictoriesCountLabel, victoriesLabelPc])
        pcVictoriesLabel.axis = .horizontal
        pcVictoriesLabel.spacing = 6
        
        let pcLoseLabel = UIStackView(arrangedSubviews: [pcLoseCountLabel, loseLabelPc])
        pcLoseLabel.axis = .horizontal
        pcLoseLabel.spacing = 6
        
        addSubviews(background, userImage, pcImage, userVictoriesLabel, userLoseLabel, pcVictoriesLabel, pcLoseLabel, vsLabel, readyLabel)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: heightAnchor),
            background.widthAnchor.constraint(equalTo: widthAnchor),
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor),
            vsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            vsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pcLoseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pcLoseLabel.bottomAnchor.constraint(equalTo: vsLabel.topAnchor, constant: -60),
            pcVictoriesLabel.bottomAnchor.constraint(equalTo: pcLoseLabel.topAnchor),
            pcVictoriesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pcImage.widthAnchor.constraint(equalToConstant: 87),
            pcImage.heightAnchor.constraint(equalToConstant: 100),
            pcImage.bottomAnchor.constraint(equalTo: pcVictoriesLabel.topAnchor, constant: -12),
            pcImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 87),
            userImage.heightAnchor.constraint(equalToConstant: 100),
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.topAnchor.constraint(equalTo: vsLabel.bottomAnchor, constant: 60),
            userVictoriesLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 12),
            userVictoriesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userLoseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userLoseLabel.topAnchor.constraint(equalTo: userVictoriesLabel.bottomAnchor),
            readyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            readyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -56)
        ])
    }
}

import SwiftUI

struct FightLoadViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea().previewInterfaceOrientation(.portrait)
    }
    struct ContainerView: UIViewRepresentable {
        let view = FightLoadView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
}

