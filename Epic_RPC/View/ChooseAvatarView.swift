//
//  ChooseAvatarView.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 14.06.2024.
//

import UIKit

final class ChooseAvatarView: UIView {
    
    //MARK: - UI Elements
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let testImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.968627451, alpha: 1)
        collectionView.layer.borderWidth = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellID")
        return collectionView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 23
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    func setView() {
        addSubview(visualEffectView)
        addSubview(containerView)
        addSubview(collectionView)
        containerView.addSubview(okButton)
        containerView.addSubview(okButton)
    }
}

    //MARK: - Set Constraints

extension ChooseAvatarView {

    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 140),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 328),
            containerView.widthAnchor.constraint(equalToConstant: 314),
            
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 11),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -11),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -114),

            okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -35),
            okButton.widthAnchor.constraint(equalToConstant: 134),
            okButton.heightAnchor.constraint(equalToConstant: 35.84),
        ])
    }
}

