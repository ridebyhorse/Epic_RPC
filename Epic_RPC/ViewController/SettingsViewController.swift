//
//  SettingsViewController.swift
//  Epic_RPC
//
//  Created by Andrey Zavershinskiy on 14.06.2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class SettingsViewController: UIViewController {

	private let settingsView = SettingsView()
    private let navBar = NavBar()
        .title("Settings")
        .leftButton(.back)
    private let disposeBag = DisposeBag()
	override func viewDidLoad() {
		super.viewDidLoad()
		view = settingsView
        setupBindings()
        navigationController?.navigationBar.isHidden = true
        view.addSubviews(navBar)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
	}

    private func setupBindings() {
        navBar.onLeftButtonTap
            .bind(onNext: { [weak self] in
                if let settings = self?.settingsView.onClose?() {
                    Game().setupGameSettings(settings: settings)
                }
                
                self?.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
