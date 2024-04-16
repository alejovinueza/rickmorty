//
//  CharacterCachingProtocol.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

protocol CharacterCaching {
    func cacheCharacters(_ characters: [Character])
    func getCachedCharacters() -> [Character]
}
