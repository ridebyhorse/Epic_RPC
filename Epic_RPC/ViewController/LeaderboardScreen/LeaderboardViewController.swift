//
//  LeaderboardViewController.swift
//  Epic_RPC
//
//  Created by dsm 5e on 09.06.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class LeaderboardViewController: UIViewController {
    
    private let navBar = NavBar()
        .title("Leaderboard")
        .leftButton(.back)
    
    private let playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .character1
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let playerNameView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(resource: .appBorder).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Player 1"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let playerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private let leaderBoardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    
    private let leaderBoardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .shield
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let playersLabel: UILabel = {
        let label = UILabel()
        label.text = "Players"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        return label
    }()

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    private func setupBindings() {
        navBar.onLeftButtonTap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

private extension LeaderboardViewController {
    func setupUI() {
        view.backgroundColor = .appLeaderboardBackground
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        
        playerNameView.addSubview(playerNameLabel)
        
        playerStack.addArrangedSubviews(
            playerImage,
            playerNameView
        )
        
        leaderBoardView.addSubviews(
            leaderBoardImage,
            playersLabel,
            rateLabel
        )

        view.addSubviews(
            navBar,
            playerStack,
            leaderBoardView
        )
    }
    
    func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide.snp.top)
            make
                .leading.trailing
                .equalToSuperview()
        }
        
        playerNameLabel.snp.makeConstraints { make in
            make
                .top.bottom.trailing
                .equalToSuperview()
            make
                .leading
                .equalToSuperview()
                .inset(20)
        }
        
        playerImage.snp.makeConstraints { make in
            make
                .size
                .equalTo(45)
        }
        
        playerStack.snp.makeConstraints { make in
            make
                .top
                .equalTo(navBar.snp.bottom)
                .offset(5)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(20)
        }
        
        leaderBoardImage.snp.makeConstraints { make in
            make
                .centerX
                .equalToSuperview()
            make
                .centerY
                .equalTo(leaderBoardView.snp.top)
                .offset(25)
        }
        
        playersLabel.snp.makeConstraints { make in
            make
                .bottom
                .equalTo(leaderBoardImage.snp.bottom)
                .inset(10)
            make
                .leading
                .equalToSuperview()
                .inset(30)
        }

        rateLabel.snp.makeConstraints { make in
            make
                .bottom
                .equalTo(leaderBoardImage.snp.bottom)
                .inset(10)
            make
                .trailing
                .equalToSuperview()
                .inset(30)
        }
        
        leaderBoardView.snp.makeConstraints { make in
            make
                .top
                .equalTo(playerStack.snp.bottom)
                .offset(45)
            make
                .leading.trailing.bottom
                .equalToSuperview()
        }
    }
}
