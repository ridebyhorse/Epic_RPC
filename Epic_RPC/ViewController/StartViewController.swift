//
//  StartViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class StartViewController: UIViewController {
    private let startView = StartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = startView
        addActions()
    }
    
    private func addActions() {
//        let tapSettings = UIAction { [unowned self] _ in
//            let settingsVC = SettingsViewController()
//            navigationController?.pushViewController(settingsVC, animated: true)
//        }
        
        let tapRules = UIAction { [unowned self] _ in
            let rulesVC = RulesViewController()
            navigationController?.pushViewController(rulesVC, animated: true)
        }
        
        let tapStart = UIAction { [unowned self] _ in
//            let fightLoadVC = FightLoadViewController()
//            navigationController?.pushViewController(fightLoadVC, animated: true)
            let gameVC = GameViewController()
            navigationController?.pushViewController(gameVC, animated: true)
        }
        
        let tapResults = UIAction { [unowned self] _ in
            let resultsVC = LeaderboardViewController()
            navigationController?.pushViewController(resultsVC, animated: true)
        }
        
//        startView.settingsButton.addAction(tapSettings, for: .touchUpInside)
        startView.rulesButton.addAction(tapRules, for: .touchUpInside)
        startView.startButton.addAction(tapStart, for: .touchUpInside)
        startView.resultsButton.addAction(tapResults, for: .touchUpInside)
    }
}
