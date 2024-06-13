//
//  ChangeUsernameView.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 13.06.2024.
//

import UIKit

class ChangeUsernameView: UIView {
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 23
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имя игрока"
        label.font = .custom(font: .regular, size: 14)
        label.textColor = #colorLiteral(red: 0.5593420267, green: 0.5592260957, blue: 0.5556153059, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imputImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "inputUsernameImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = .custom(font: .bold, size: 16)
        textField.textColor = #colorLiteral(red: 0.3012940884, green: 0.3054938018, blue: 0.2969334126, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "okButtonUsernameVC"), for: .normal)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = .custom(font: .bold, size: 16)
        button.tintColor = #colorLiteral(red: 0.9931924939, green: 0.8798548579, blue: 0.8072456121, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChangeUsernameView {
    
    func setView() {
        addSubview(visualEffectView)
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imputImageView)
        containerView.addSubview(textField)
        containerView.addSubview(okButton)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 140),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 199),
            containerView.widthAnchor.constraint(equalToConstant: 314),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 31),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            imputImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imputImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            imputImageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            imputImageView.heightAnchor.constraint(equalToConstant: 45),
            
            textField.topAnchor.constraint(equalTo: imputImageView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: imputImageView.leadingAnchor, constant: 14),
            textField.trailingAnchor.constraint(equalTo: imputImageView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: imputImageView.bottomAnchor),

            okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.widthAnchor.constraint(equalToConstant: 134),
            okButton.heightAnchor.constraint(equalToConstant: 35.84),
        ])
    }
}

