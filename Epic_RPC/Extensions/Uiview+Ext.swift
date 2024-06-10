//
//  Uiview+Ext.swift
//  Epic_RPC
//
//  Created by dsm 5e on 09.06.2024.
//

import UIKit

extension UIView {
  public func addSubviews(_ subviews: UIView...) {
    subviews.forEach(addSubview)
  }
  
  public func addSubviewsList(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
}
