//
//  ResultView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class ResultView: UIView {
    
    //MARK: - UI Elements
    
    var backgroundImageView = UIImageView(
        image: UIImage(named: "winBackground")
    )
    var characterImageView = UIImageView(
        image: UIImage(named: "firstCharacter")
    )
    let rectangleImageView = UIImageView(
        image: UIImage(named: "rectangleImage")
    )
    
    var resultLabel = UILabel()
    var scoreLabel = UILabel()
    let homeButton = UIButton()
    let repeatButton = UIButton()
    
    let stackView = UIStackView()
    let buttonsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultView {
    //MARK: - Setup UI
    
    func setupViews() {
        
        addSubview(backgroundImageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(rectangleImageView)
        stackView.addArrangedSubview(resultLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(buttonsStackView)
        
        stackView.setCustomSpacing(26, after: rectangleImageView)
        stackView.setCustomSpacing(6, after: resultLabel)
        stackView.setCustomSpacing(34, after: scoreLabel)
        stackView.axis = .vertical
        
        characterImageView.contentMode = .scaleAspectFit
        
        rectangleImageView.contentMode = .scaleAspectFit
        rectangleImageView.addSubview(characterImageView)
        
        resultLabel.textAlignment = .center
        resultLabel.font = .custom(font: .bold, size: 21)
        resultLabel.text = "You Win"
        resultLabel.textColor = #colorLiteral(red: 1, green: 0.7480235696, blue: 0.367166698, alpha: 1)
        
        scoreLabel.textAlignment = .center
        scoreLabel.font = .custom(font: .medium, size: 41)
        scoreLabel.text = "3 - 1"
        scoreLabel.textColor = .white
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 42
        buttonsStackView.addArrangedSubview(homeButton)
        buttonsStackView.addArrangedSubview(repeatButton)
        
        homeButton.setBackgroundImage(UIImage(named: "homeButtonResultVC"), for: .normal)
        repeatButton.setBackgroundImage(UIImage(named: "repeatButtonResultVC"), for: .normal)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            characterImageView.centerXAnchor.constraint(equalTo: rectangleImageView.centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: rectangleImageView.centerYAnchor),
            
            rectangleImageView.heightAnchor.constraint(equalToConstant: 176),
            resultLabel.heightAnchor.constraint(equalToConstant: 25),
            scoreLabel.heightAnchor.constraint(equalToConstant: 49),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 52),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 368),
            stackView.widthAnchor.constraint(equalToConstant: 177),
        ])
    }
}

import SwiftUI

struct ResultViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea().previewInterfaceOrientation(.portrait)
    }
    struct ContainerView: UIViewRepresentable {
        let view = ResultView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
}

