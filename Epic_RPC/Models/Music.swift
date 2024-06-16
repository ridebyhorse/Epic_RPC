//
//  Music.swift
//  Epic_RPC
//
//  Created by Мария Нестерова on 16.06.2024.
//

import Foundation

enum Music: String {
    case tenseTheme = "Tense Theme"
    case bassTheme = "Bass Theme"
    case mainTheme = "Main Theme"
}

struct MusicManager {
    static func getMusicFor(_ name: Music) -> URL? {
        switch name {
        case .tenseTheme:
            return Bundle.main.url(forResource: "320553__griffon_designs__dirty-grind", withExtension: "aiff")
        case .bassTheme:
            return Bundle.main.url(forResource: "512379__mrthenoronha__bass-line-theme-loop", withExtension: "wav")
        case .mainTheme:
            return Bundle.main.url(forResource: "449640__cnupoc__main-theme", withExtension: "mp3")
        }
    }
}
