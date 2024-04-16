//
//  MockCharacterCache.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

class MockCharacterCache: CharacterCaching {
    private var characters: [Int: Character] = [:]

    func cacheCharacters(_ characters: [Character]) {
        for character in characters {
            self.characters[character.id] = character
        }
    }

    func getCachedCharacters() -> [Character] {
        return Array(characters.values)
    }
}
