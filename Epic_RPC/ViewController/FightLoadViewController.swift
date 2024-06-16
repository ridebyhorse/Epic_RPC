//
//  FightLoadViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class FightLoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view = FightLoadView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.navigationController?.pushViewController(GameViewController(), animated: true)
        }
    }

}
