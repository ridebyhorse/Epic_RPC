//
//  ResultViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    let resultView: ResultView
    
    init(result: Bool, scorePlayer: Int, pcPlayerScore: Int) {
        resultView = ResultView(result: result, playerScore: scorePlayer, pcPlayerScore: pcPlayerScore)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            navigationController?.pushViewController(FightLoadViewController(), animated: true)
        }
        
        resultView.homeButton.addAction(homeButtonPressed, for: .touchUpInside)
        resultView.repeatButton.addAction(repeatButtonPressed, for: .touchUpInside)
    }
}
