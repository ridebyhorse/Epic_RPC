//
//  CharacterCell.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 14.06.2024.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    static let reuseID = "CharacterCell"
    
    //MARK: - UI Elements
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "character1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.968627451, alpha: 1)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var checkBoxImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.7843137255, blue: 0.4039215686, alpha: 1)
                checkBoxImage.image = UIImage(named: "checkBoxImage")
            } else {
                containerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.968627451, alpha: 1)
                checkBoxImage.image = .none
            }
        }
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(checkBoxImage)
    }
}

    // MARK: - Set Constraints

extension CharacterCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            checkBoxImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6.17),
            checkBoxImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6.66),
            
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
}
