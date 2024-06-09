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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LeaderbordPlayerCell.self, forCellReuseIdentifier: "LeaderbordPlayerCell")
        return table
    }()
    
    private let players: [Player] = [
        .init(image: "character2", name: "Name name", score: 231, rate: 34),
        .init(image: "character1", name: "Test name", score: 231, rate: 34),
        .init(image: "character4", name: "Person name", score: 231, rate: 34),
        .init(image: "character1", name: "OOo name", score: 231, rate: 34),
        .init(image: "character1", name: "Test name", score: 231, rate: 34),
        .init(image: "character4", name: "Person name", score: 231, rate: 34),
        .init(image: "character1", name: "OOo name", score: 231, rate: 34)
    ]
    
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

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderbordPlayerCell", for: indexPath) as! LeaderbordPlayerCell
        let player = players[indexPath.row]
        cell.configure(with: player, position: indexPath.row + 1)
        return cell
    }
}

private extension LeaderboardViewController {
    func setupUI() {
        view.backgroundColor = .appLeaderboardBackground
        navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
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
            rateLabel,
            tableView
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
        
        tableView.snp.makeConstraints { make in
            make
                .top
                .equalTo(leaderBoardImage.snp.bottom)
            make
                .leading.trailing.bottom
                .equalToSuperview()
                .inset(20)
        }
    }
}
