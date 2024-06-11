//
//  ResultViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    let resultView = ResultView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: true)
        view = resultView
        addActions()
    }
    
    private func addActions() {
        
        let homeButtonPressed = UIAction { [unowned self] _ in
            navigationController?.popToRootViewController(animated: true)
        }
        
        let repeatButtonPressed = UIAction { [unowned self] _ in
//            let fightLoadVC = FightLoadViewController()
//            navigationController?.pushViewController(fightLoadVC, animated: true)
            let gameVC = GameViewController()
            navigationController?.pushViewController(gameVC, animated: true)
        }
        
        resultView.homeButton.addAction(homeButtonPressed, for: .touchUpInside)
        resultView.repeatButton.addAction(repeatButtonPressed, for: .touchUpInside)
    }
}
