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
    
    private func setupViews() {
        settingsButton.setBackgroundImage(UIImage(named: "settingsStartVC"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(settingsButton)
        
        helpInfoButton.setBackgroundImage(UIImage(named: "helpInfoStartVC"), for: .normal)
        helpInfoButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(helpInfoButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            
            helpInfoButton.widthAnchor.constraint(equalToConstant: 40),
            helpInfoButton.heightAnchor.constraint(equalToConstant: 40),
            helpInfoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            helpInfoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        ])
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
