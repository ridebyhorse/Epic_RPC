//
//  RulesViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RulesViewController: UIViewController {

    private let navBar = NavBar()
        .title("Rules")
        .leftButton(UIImage(named: "back"))

    private let rulesView = RulesView()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rulesView
        setupBindings()
        setNavigationBar()
    }

    private func setupBindings() {
        navBar.onLeftButtonTap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                self?.navigationController?.navigationBar.isHidden = false
            })
            .disposed(by: disposeBag)
    }

    private func setNavigationBar() {
        view.addSubviews(navBar)
        navigationController?.navigationBar.isHidden = true

        navBar.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide.snp.top)
            make
                .leading.trailing
                .equalToSuperview()
        }
    }
}
