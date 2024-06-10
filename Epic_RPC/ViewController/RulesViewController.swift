//
//  RulesViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class RulesViewController: UIViewController {
    private let rulesView = RulesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rulesView
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 24)]
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        title = "Rules"
    }
}
