//
//  LeaderbordPlayerCell.swift
//  Epic_RPC
//
//  Created by dsm 5e on 10.06.2024.
//

import UIKit

class LeaderbordPlayerCell: UITableViewCell {
    
    private let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let playerScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let playerRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let spacer = UIView()
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with player: Player, position: Int) {
        playerImageView.image = UIImage(named: player.image ?? "character1")
        playerNameLabel.text = player.name
        playerScoreLabel.text = "\(player.score)"
        playerRateLabel.text = "\(player.rate)%"
        
        switch position {
        case 1: backgroundColor = .leaderbordGold
        case 2: backgroundColor = .leaderbordSilver
        case 3: backgroundColor = .leaderbordBronze
        default:
            backgroundColor = .white
            positionLabel.text = "\(position)"
        }
    }
    
    private func setupUI() {
        layer.cornerRadius = 20
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        containerStack.addArrangedSubviews(
            positionLabel,
            playerImageView,
            playerNameLabel,
            spacer,
            playerScoreLabel,
            playerRateLabel
        )
        contentView.addSubview(containerStack)
    }
    
    private func setupConstraints() {
        playerImageView.snp.makeConstraints { make in
            make.size.equalTo(45)
        }
        containerStack.snp.makeConstraints { make in
            make
                .edges
                .equalToSuperview()
                .inset(10)
        }
    }
}
