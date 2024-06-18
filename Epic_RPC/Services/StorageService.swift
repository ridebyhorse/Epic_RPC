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

    private func addPlayer(_ player: Player) {
        var currentPlayers = getPlayers()
        if !currentPlayers.contains(where: { $0.name == player.name }) {
            currentPlayers.append(player)
            savePlayers(currentPlayers)
        }
    }
    
    func updateAvatar(name: String, avatar: String) {
        var currentPlayers = getPlayers()
        if let index = currentPlayers.firstIndex(where: { $0.name == name }) {
            var user = currentPlayers[index]
            user.image = avatar
            currentPlayers.remove(at: index)
            currentPlayers.insert(user, at: index)
            savePlayers(currentPlayers)
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
            let pcPlayer = Player(image: "avatar_pc", name: "PC")
            addPlayer(pcPlayer)
            return pcPlayer
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
