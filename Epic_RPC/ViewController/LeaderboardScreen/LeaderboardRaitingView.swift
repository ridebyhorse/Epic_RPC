//
//  LeaderboardRaitingView.swift
//  Epic_RPC
//
//  Created by dsm 5e on 09.06.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxGesture

class LeaderboardRaitingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        
    }
}

private extension LeaderboardRaitingView {
    func setupUI() {
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}
