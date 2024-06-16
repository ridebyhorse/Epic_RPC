//
//  SettingsViewController.swift
//  Epic_RPC
//
//  Created by Andrey Zavershinskiy on 14.06.2024.
//

import UIKit

final class SettingsViewController: UIViewController {

	private let settingsView = SettingsView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view = settingsView
		setNavigationBar()
	}

	private func setNavigationBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 24)]
		appearance.shadowColor = nil

		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.tintColor = .black
		title = "Settings"
	}
}
