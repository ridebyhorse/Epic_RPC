//
//  UIStackView+Ext.swift
//  Epic_RPC
//
//  Created by dsm 5e on 09.06.2024.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
