//
//  RulesView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class RulesView: UIView {

    private let rulesArray = [
        RuleModel(label: "Игра проводится между игроком и компьютером.", image: "number1", isGesture: false),
        RuleModel(label: "Жесты:", image: "number2", isGesture: false),
        RuleModel(label: "Кулак > Ножницы", image: "button_game_stone", isGesture: true),
        RuleModel(label: "Бумага > Кулак", image: "button_game_paper", isGesture: true),
        RuleModel(label: "Ножницы > Бумага", image: "button_game_scissors", isGesture: true),
        RuleModel(label: "У игрока есть 30 сек. или 60 сек. для выбора жеста.", image: "number3", isGesture: false),
        RuleModel(label: "Игра ведётся до трёх побед одного из участников.", image: "number4", isGesture: false),
        RuleModel(label: "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров.", image: "number5", isGesture: false)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        createVerticalStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Label
    private func createRuleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = #colorLiteral(red: 0.2314755321, green: 0.2274348438, blue: 0.227404356, alpha: 1)
        label.dropShadow()
        label.font = .custom(font: .regular, size: 16)
        return label
    }
    
    // Image
    private func createRuleImage(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: named)
        imageView.dropShadow()
        return imageView
    }
    
    //MARK: - Create Horizontal Stack
    
    private func createHorizontalStack(text: String, image: String, isGestue: Bool) -> UIStackView  {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 11
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let ruleLabel = createRuleLabel(text: text)
        let ruleImage = createRuleImage(named: image)
        let isGesture = isGestue
        
        stackView.addArrangedSubview(ruleImage)
        stackView.addArrangedSubview(ruleLabel)

        if ruleLabel.text == "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров." {
            ruleLabel.halfTextColorChange(fullText: ruleLabel.text!, changeText: "500 баллов")
        }
        
        if isGesture == true {
            NSLayoutConstraint.activate([
                ruleImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                ruleImage.heightAnchor.constraint(equalToConstant: 30),
                ruleImage.widthAnchor.constraint(equalToConstant: 30),
                ruleImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 36),
                
            ])
        } else {
            NSLayoutConstraint.activate([
                ruleImage.heightAnchor.constraint(equalToConstant: 29),
                ruleImage.widthAnchor.constraint(equalToConstant: 29),
            ])
        }
        return stackView
    }
    
    //MARK: - Create Vertical Stack
    
    func createVerticalStack() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for element in rulesArray {
            let rule = createHorizontalStack(text: element.label, image: element.image, isGestue: element.isGesture)
            verticalStackView.addArrangedSubview(rule)
        }
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 115),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
