//
//  NavigationBar.swift
//  Epic_RPC
//
//  Created by dsm 5e on 09.06.2024.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture

class NavBar: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 25)
        //label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(.back.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()

    private let rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()

    var onLeftButtonTap = PublishRelay<Void>()
    var onRightButtonTap = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        setupUI()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupBindings() {
        leftButton.rx.tap
            .bind(to: onLeftButtonTap)
            .disposed(by: disposeBag)

        leftButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.animate(view: self?.leftButton)
            })
            .disposed(by: disposeBag)

        rightButton.rx.tap
            .bind(to: onRightButtonTap)
            .disposed(by: disposeBag)

        rightButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.animate(view: self?.rightButton)
            })
            .disposed(by: disposeBag)
    }

    private func animate(view: UIView?) {
        guard let view = view else { return }
        UIView.animate(
            withDuration: 0.15,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    view.transform = CGAffineTransform.identity
                }
            }
        )
    }
}

// MARK: - setup UI
private extension NavBar {
     func setupUI() {
        addSubviews(leftButton, titleLabel, rightButton)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }

        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(28)
        }

        self.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
}

// MARK: - Cutsom Init
extension NavBar {
    func title(_ title: String?) -> Self {
        self.titleLabel.text = title
        return self
    }

    func leftButton(_ image: UIImage?) -> Self {
        self.leftButton.setImage(image, for: .normal)
        return self
    }

    func rightButton(_ image: UIImage?) -> Self {
        self.rightButton.setImage(image, for: .normal)
        return self
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout, body: {
    let view =  UIView()
    let button: NavBar = {
        NavBar()
            .title("Leaderboard")
            .leftButton(.back)
    }()

    view.addSubviews(button)
    
    button.snp.makeConstraints { make in
        make.top.leading.trailing.equalToSuperview()
        make.center.equalToSuperview()
    }
    return view
})
