//
//  StartView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class StartView: UIView {
    private let settingsButton = UIButton()
    private let helpInfoButton = UIButton()
    private let startButton = UIButton()
    private let resultsButton = UIButton()
    private let backgroundImageView = UIImageView(
        image: UIImage(named: "imageStartVC")
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayout()
    }
    
}

// MARK: - Private Methods
private extension StartView {
    func setupViews() {
        backgroundColor = .systemGray6
        
        settingsButton.setBackgroundImage(UIImage(named: "settingsStartVC"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(settingsButton)
        
        helpInfoButton.setBackgroundImage(UIImage(named: "helpInfoStartVC"), for: .normal)
        helpInfoButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(helpInfoButton)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        
        setCustomButton(startButton, withTitle: "START")
        setCustomButton(resultsButton, withTitle: "RESULTS")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 35),
            settingsButton.heightAnchor.constraint(equalToConstant: 35),
            settingsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            
            helpInfoButton.widthAnchor.constraint(equalToConstant: 35),
            helpInfoButton.heightAnchor.constraint(equalToConstant: 35),
            helpInfoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            helpInfoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            resultsButton.widthAnchor.constraint(equalToConstant: 200),
            resultsButton.heightAnchor.constraint(equalToConstant: 50),
            resultsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -16)
        ])
    }
    
    func setCustomButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.brown, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        button.setBackgroundImage(UIImage(named: "buttonStartVC"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }
}

import SwiftUI

struct StartViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = StartView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
