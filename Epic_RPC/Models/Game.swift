//
//  Game.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 11.06.2024.
//

import Foundation

enum GameGesture {
    case rock
    case paper
    case scissors
}

struct Game {
    
    private (set) static var currentSettings: Settings = Settings(firstPlayer: Player(image: "avatar_user", name: "Player 1", score: 0, rate: 0), secondPlayer: nil, roundTime: .s30, music: nil)
    
    func calculateWin(user: GameGesture, pc: GameGesture) -> Bool? {
        check(user, pc)
    }
    
    func setupGameSettings(settings: Settings) {
        Game.currentSettings = settings
    }
    
    private func check(_ g1: GameGesture, _ g2: GameGesture) -> Bool? {
        if g1 == g2 { return nil }
        switch g1 {
        case .rock:
            if g2 == .scissors {
                return true
            } else {
                return false
            }
        case .paper:
            if g2 == .rock {
                return true
            } else {
                return false
            }
        case .scissors:
            if g2 == .paper {
                return true
            } else {
                return false
            }
        }
    }
}
