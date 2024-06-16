//
//  UILabel + Ext.swift
//  Epic_RPC
//
//  Created by Елена Логинова on 16.06.2024.
//

import UIKit

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let attribute = NSMutableAttributedString.init(string: fullText); attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.3568627451, green: 0.3607843137, blue: 0.6470588235, alpha: 1), range:NSRange(location: 32, length: 10) )
        self.attributedText = attribute }
}
