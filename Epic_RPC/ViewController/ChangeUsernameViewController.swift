//
//  ChangeUsernameViewController.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 13.06.2024.
//

import UIKit

class ChangeUsernameViewController: UIViewController {
    
    let changeUsernameView = ChangeUsernameView()
    var getUsername: ((String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = changeUsernameView
        addActions()
    }
    
    func addActions() {
        
        let okButtonPressed = UIAction { [unowned self] _ in
            guard let text = changeUsernameView.textField.text else { return }
            getUsername?(text)
            dismiss(animated: true)
        }
        changeUsernameView.okButton.addAction(okButtonPressed, for: .touchUpInside)
    }
}
