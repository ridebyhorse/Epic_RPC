//
//  PauseView.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 15.06.2024.
//

import UIKit

class PauseView: UIView {
    
    var onHomeTap: (() -> Void)?
    var onPlayTap: (() -> Void)?

    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.2
        
        return view
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(.homeButtonResultVC, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(.playButtonPauseVC, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(visualEffectView)
        addSubviews(homeButton)
        addSubview(playButton)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            visualEffectView.widthAnchor.constraint(equalTo: widthAnchor),
            visualEffectView.heightAnchor.constraint(equalTo: heightAnchor),
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 52),
            homeButton.widthAnchor.constraint(equalToConstant: 67),
            homeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            playButton.heightAnchor.constraint(equalToConstant: 52),
            playButton.widthAnchor.constraint(equalToConstant: 67),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50),
        ])
    }
    
    @objc private func homeTapped(_ sender: UIButton) {
        onHomeTap?()
    }
    
    @objc private func playTapped(_ sender: UIButton) {
        onPlayTap?()
    }
}
