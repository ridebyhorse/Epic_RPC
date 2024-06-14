//
//  LeaderbordPlayerCell.swift
//  Epic_RPC
//
//  Created by dsm 5e on 10.06.2024.
//

import UIKit

class LeaderbordPlayerCell: UITableViewCell {
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .black
        return label
    }()
    
    private let playerRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .black
        return label
    }()
        
    private let spacer = UIView()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private let medalImage: UIImageView = {
        let imageView = UIImageView(image: .gold)
        imageView.isHidden = true
        return imageView
    }()

    private let containerView = UIView()
        
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
        let rate: Float = Float(player.victories) / Float(player.victories + player.loses) * 100.0
        playerRateLabel.text = "\(Int(rate))%"

        switch position {
        case 1:
            containerView.backgroundColor = .leaderbordGold.withAlphaComponent(0.5)
            containerView.layer.cornerRadius = 20
            medalImage.image = .gold
            medalImage.isHidden = false
        case 2:
            containerView.backgroundColor = .leaderbordSilver.withAlphaComponent(0.5)
            containerView.layer.cornerRadius = 20
            medalImage.image = .silver
            medalImage.isHidden = false
        case 3:
            containerView.backgroundColor = .leaderbordBronze.withAlphaComponent(0.5)
            containerView.layer.cornerRadius = 20
            medalImage.image = .bronze
            medalImage.isHidden = false
        default:
            positionLabel.text = "\(position)"
            containerView.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
            medalImage.isHidden = true
        }
    }

    private func setupUI() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentStack.addArrangedSubviews(
            positionLabel,
            playerImageView,
            playerNameLabel,
            spacer,
            playerScoreLabel,
            playerRateLabel
        )
        
        containerView.addSubviews(
            contentStack,
            medalImage
        )
        contentView.addSubview(containerView)
    }
    
    private func setupConstraints() {
        
        playerImageView.snp.makeConstraints { make in
            make
                .size
                .equalTo(35)
        }
        
        contentStack.snp.makeConstraints { make in
            make
                .top.leading.bottom
                .equalToSuperview()
                .inset(5)
            make
                .trailing
                .equalToSuperview()
                .inset(20)
        }
        
        medalImage.snp.makeConstraints { make in
            make
                .centerY
                .equalTo(containerView.snp.centerY)
            make
                .trailing
                .equalTo(containerView.snp.trailing)
                .offset(5)
            make
                .size
                .equalTo(17)
        }
        
        containerView.snp.makeConstraints { make in
            make
                .top.leading.trailing.bottom
                .equalToSuperview()
                .inset(5)
            
            make.height
                .equalTo(60)
        }
    }
}
