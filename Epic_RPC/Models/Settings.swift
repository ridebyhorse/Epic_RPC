//
//  Settings.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 13.06.2024.
//

import Foundation

enum RoundTime: Int, Codable {
    case s30 = 30
    case s60 = 60
}

struct Settings: Codable {
    var firstPlayer: Player
    var secondPlayer: Player?
    let roundTime: RoundTime
    let music: String?
}
