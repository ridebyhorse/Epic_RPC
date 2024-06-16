//
//  ChooseAvatarViewController.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 14.06.2024.
//

import UIKit

class ChooseAvatarViewController: UIViewController {
    
    var number = 0
    
    let charactersArray: [UIImage?] = [
        UIImage(named: "character1"),
        UIImage(named: "character2"),
        UIImage(named: "character3"),
        UIImage(named: "character6"),
        UIImage(named: "character5"),
        UIImage(named: "character7"),
        UIImage(named: "character4"),
        UIImage(named: "character8")
        ]

    let chooseAvatarView = ChooseAvatarView()
    var getAvatar: ((UIImage, String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addActions()
    }
    
    func setupView() {
        view = chooseAvatarView
        self.chooseAvatarView.collectionView.dataSource = self
        self.chooseAvatarView.collectionView.delegate = self
    }

    func addActions() {
        
        let okButtonPressed = UIAction { [unowned self] _ in
            guard let avatar = chooseAvatarView.testImageView.image else { return }
            let name: String
            switch number {
            case 0:
                name = "character1"
            case 1:
                name = "character2"
            case 2:
                name = "character3"
            case 3:
                name = "character4"
            case 4:
                name = "character5"
            case 5:
                name = "character6"
            case 6:
                name = "character7"
            case 7:
                name = "character8"
            default:
                name = "character1"
            }
            getAvatar?(avatar, name)
            dismiss(animated: true)
        }
        chooseAvatarView.okButton.addAction(okButtonPressed, for: .touchUpInside)
    }
}

//MARK: - UICollectionViewDelegate

extension ChooseAvatarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chooseAvatarView.testImageView.image = charactersArray[indexPath.item]
        number = indexPath.item
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ChooseAvatarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 58, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 28.31, left: 11, bottom: 24.85, right: 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
}

//MARK: - UICollectionView Data Source

extension ChooseAvatarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseID, for: indexPath) as? CharacterCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellID", for: indexPath) }
        let image = charactersArray[indexPath.row]
        cell.avatarImageView.image = image
        
        return cell
        
    }
}
