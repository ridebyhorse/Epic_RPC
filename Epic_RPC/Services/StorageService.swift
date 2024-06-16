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
    private let settingsKey = "settings"

    static let shared = StorageService()

    private init() {}

    func getMockPlayers() -> [Player] {
        [
            .init(image: "character2", name: "Tony Newman", score: 23500, victories: 47, loses: 30),
            .init(image: "character1", name: "Herman Welch", score: 12000, victories: 24, loses: 11),
            .init(image: "character4", name: "Dollie Mann", score: 7000, victories: 14, loses: 3),
            .init(image: "character1", name: "Ian Burton", score: 11500, victories: 23, loses: 18),
            .init(image: "character1", name: "Roxie Hansen", score: 2500, victories: 5, loses: 2),
            .init(image: "character4", name: "Steven Vaughn", score: 19000, victories: 38, loses: 21),
            .init(image: "character1", name: "Harriett Single", score: 5500, victories: 11, loses: 4)
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
        if !currentPlayers.contains(where: { $0.name == player.name }) {
            currentPlayers.append(player)
            savePlayers(currentPlayers)
        } else {
            if let index = currentPlayers.firstIndex(where: { $0.name == player.name }) {
                var user = currentPlayers[index]
                if user.image != player.image {
                    user.image = player.image
                    currentPlayers.remove(at: index)
                    currentPlayers.insert(user, at: index)
                    savePlayers(currentPlayers)
                }
            }
        }
    }
    
    ///обновляет количество побед или поражений (и score) по userName
    func updateUserStatistics(username: String, win: Bool) {
        var currentPlayers = getPlayers()
        if let index = currentPlayers.firstIndex(where: { $0.name == username }) {
            var user = currentPlayers[index]
            if win {
                user.victories += 1
                user.score += 500
            } else {
                user.loses += 1
            }
            currentPlayers.remove(at: index)
            currentPlayers.insert(user, at: index)
            savePlayers(currentPlayers)
        }
    }
    
    ///сохраняет текущие настройки
    func saveSettings(_ settings: Settings) {
        addPlayer(settings.firstPlayer)
        if let player2 = settings.secondPlayer {
            addPlayer(player2)
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(settings)
            userDefaults.set(data, forKey: settingsKey)
        } catch {
            print("Error encoding settings: \(error)")
        }
    }
    
    ///возвращает настройки последней игры
    func getLastSettings() -> Settings? {
        if let data = userDefaults.data(forKey: settingsKey) {
            do {
                let decoder = JSONDecoder()
                var settings = try decoder.decode(Settings.self, from: data)
                if let player1 = getPlayer(username: settings.firstPlayer.name) {
                    settings.firstPlayer = player1
                }
                if let player2 = settings.secondPlayer {
                    if let user = getPlayer(username: player2.name) {
                        settings.secondPlayer = user
                    }
                }
                return settings
            } catch {
                print("Error decoding players: \(error)")
            }
        }
        return nil
    }
    
    ///возвращает игрока - дефолтного противника
    func getPcPlayer() -> Player {
        let currentPlayers = getPlayers()
        if let index = currentPlayers.firstIndex(where: { $0.name == "PC" }) {
            return currentPlayers[index]
        } else {
            return Player(image: "avatar_pc", name: "PC")
        }
    }
    
    private func getPlayer(username: String) -> Player? {
        let currentPlayers = getPlayers()
        if let index = currentPlayers.firstIndex(where: { $0.name == username }) {
            return currentPlayers[index]
        }
        return nil
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
