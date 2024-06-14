//
//  StorageService.swift
//  Epic_RPC
//
//  Created by dsm 5e on 10.06.2024.
//

import Foundation

class StorageService {
    private let userDefaults = UserDefaults.standard
    private let playersKey = "players"

    static let shared = StorageService()

    private init() {}

    func getMockPlayers() -> [Player] {
        [
            .init(image: "character2", name: "Name name", score: 231, victories: 32, loses: 4),
            .init(image: "character1", name: "Test name", score: 231, victories: 32, loses: 4),
            .init(image: "character4", name: "Person name", score: 231, victories: 32, loses: 4),
            .init(image: "character1", name: "OOo name", score: 231, victories: 32, loses: 4),
            .init(image: "character1", name: "Test name", score: 231, victories: 32, loses: 4),
            .init(image: "character4", name: "Person name", score: 231, victories: 32, loses: 4),
            .init(image: "character1", name: "OOo name", score: 231, victories: 32, loses: 4)
        ]
    }

    func getPlayers() -> [Player] {
        if let data = userDefaults.data(forKey: playersKey) {
            do {
                let decoder = JSONDecoder()
                let players = try decoder.decode([Player].self, from: data)
                return players
            } catch {
                print("Error decoding players: \(error)")
            }
        }
        return []
    }

    func addPlayer(_ player: Player) {
        var currentPlayers = getPlayers()
        currentPlayers.append(player)
        savePlayers(currentPlayers)
    }
    
    ///обновляет количество побед или поражений (и score) по userName
    func updateUserStatistics(username: String, win: Bool) {
        
    }
    
    ///сохраняет текущие настройки
    func saveSettings() {
        
    } 
    
    ///устанавливает настройки последней игры
    func setupLastSettings() {
        
    }

    private func savePlayers(_ players: [Player]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(players)
            userDefaults.set(data, forKey: playersKey)
        } catch {
            print("Error encoding players: \(error)")
        }
    }
}
