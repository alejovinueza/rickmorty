//
//  AdvancedCharacterCache.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

class AdvancedCharacterCache: CharacterCaching {
    private var cache = [Int: Character]()

    func cacheCharacters(_ characters: [Character]) {
        characters.forEach { cache[$0.id] = $0 }
    }

    func getCachedCharacters() -> [Character] {
        return Array(cache.values)
    }

    func getCachedCharacter(byId id: Int) -> Character? {
        return cache[id]
    }
}
