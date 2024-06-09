//
//  StartViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController {
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("open leaderboard", for: .normal)
        btn.backgroundColor = .black
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupBindings() {
        button.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let leaderboardVC = LeaderboardViewController()
                leaderboardVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.present(leaderboardVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

private extension StartViewController {
    func setupUI() {
        view.backgroundColor = .appBackground
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(button)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
