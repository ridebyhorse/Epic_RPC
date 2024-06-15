//
//  PauseViewController.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 15.06.2024.
//

import UIKit

class PauseViewController: UIViewController {
    
    private let pauseView = PauseView()
    
    init(onHomeTap: (() -> Void)?, onPlayTap: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        pauseView.onHomeTap = { [weak self] in
            self?.dismiss(animated: true)
            guard let actionOnClose = onHomeTap else { return }
            actionOnClose()
        }
        pauseView.onPlayTap = { [weak self] in
            self?.dismiss(animated: true)
            guard let actionOnClose = onPlayTap else { return }
            actionOnClose()
        }
        view = pauseView
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
