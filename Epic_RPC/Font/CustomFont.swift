//
//  CustomFont.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

enum CustomFont: String {
    ///Weight 400
    case regular = "Rubik-Regular"
    ///Weight 500
    case medium = "Rubik-Medium"
    ///Weight 700
    case bold = "Rubik-Bold"
}

extension UIFont {
    ///Пример использования: label.font = .custom(font: .bold, size: 22)
    static func custom(font: CustomFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
          fatalError(
            "Failed to load the \(font.rawValue) font."
          )
        }
        return customFont
      }
}
