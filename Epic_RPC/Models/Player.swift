//
//  Player.swift
//  Epic_RPC
//
//  Created by dsm 5e on 10.06.2024.
//

import Foundation

struct Player: Codable {
    var image: String?
    var name: String
    var score: Int = 0
    var victories: Int = 0
    var loses: Int = 0
}
