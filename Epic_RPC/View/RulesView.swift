//
//  RulesView.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

final class RulesView: UIView {
    private let rulesImageView = UIImageView(image: UIImage(named: "rules"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayout()
    }
}

// MARK: - Private Methods
private extension RulesView {
    func setupViews() {
        backgroundColor = .white
        rulesImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rulesImageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            rulesImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rulesImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}

import SwiftUI

struct RulesViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = RulesView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
