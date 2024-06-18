//
//  StartView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class StartView: UIView {
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "settingsButtonStartVC"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "rulesButtonStartVC"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 54
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var maleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var femaleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var femaleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "femaleHandStartVC")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var maleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "maleHandStartVC")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageEpicRPC: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "imageEpicRPC")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resultsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        animateElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setCustomButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.brown, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        button.setBackgroundImage(UIImage(named: "buttonStartVC"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }
}

// MARK: - Private Methods
private extension StartView {
    func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9843137255, alpha: 1)
        addSubview(stackView)
        addSubview(settingsButton)
        addSubview(rulesButton)
        stackView.addSubview(maleView)
        stackView.addSubview(femaleView)
        stackView.addSubview(imageEpicRPC)
        
        maleView.addSubview(maleImageView)
        femaleView.addSubview(femaleImageView)
        
        setCustomButton(startButton, withTitle: "START")
        setCustomButton(resultsButton, withTitle: "RESULTS")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 318),
            
            imageEpicRPC.heightAnchor.constraint(equalToConstant: 36),
            imageEpicRPC.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            imageEpicRPC.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            maleView.topAnchor.constraint(equalTo: stackView.topAnchor),
            maleView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            maleView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            maleView.heightAnchor.constraint(equalToConstant: 89),
            
            maleImageView.centerYAnchor.constraint(equalTo: maleView.centerYAnchor),
            maleImageView.trailingAnchor.constraint(equalTo: maleView.trailingAnchor),
            maleImageView.topAnchor.constraint(equalTo: maleView.topAnchor),
            
            femaleView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            femaleView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            femaleView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            femaleView.heightAnchor.constraint(equalToConstant: 89),
        
            femaleImageView.leadingAnchor.constraint(equalTo: femaleView.leadingAnchor),
            femaleImageView.bottomAnchor.constraint(equalTo: femaleView.bottomAnchor),
            femaleImageView.centerYAnchor.constraint(equalTo: femaleView.centerYAnchor),
            
            resultsButton.widthAnchor.constraint(equalToConstant: 200),
            resultsButton.heightAnchor.constraint(equalToConstant: 50),
            resultsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -16),
            
            settingsButton.widthAnchor.constraint(equalToConstant: 35),
            settingsButton.heightAnchor.constraint(equalToConstant: 35),
            settingsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            
            rulesButton.widthAnchor.constraint(equalToConstant: 35),
            rulesButton.heightAnchor.constraint(equalToConstant: 35),
            rulesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            rulesButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        ])
    }
}

//MARK: - Animation of UI Elements
private extension StartView {
    func animateElements() {
        femaleView.transform = CGAffineTransform(translationX: -250, y: 0)
        maleView.transform = CGAffineTransform(translationX: 250, y: 0)
        StartView.animate(withDuration: 1.0, delay: 0.5) {
            self.femaleView.transform = .identity
            self.maleView.transform = .identity
        }
        
        startButton.transform = CGAffineTransform(translationX: 0, y: 812)
        resultsButton.transform = CGAffineTransform(translationX: 0, y: 812)
        StartView.animate(withDuration: 1.5, delay: 1.0) {
            self.startButton.transform = .identity
            self.resultsButton.transform = .identity
        }
        
        settingsButton.transform = CGAffineTransform(translationX: 0, y: -812)
        rulesButton.transform = CGAffineTransform(translationX: 0, y: -812)
        StartView.animate(withDuration: 1.5, delay: 1.5) {
            self.settingsButton.transform = .identity
            self.rulesButton.transform = .identity
        }
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
