//
//  CharacterServiceProtocol.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) async throws -> CharacterResponse
    func fetchCharacterById(_ id: Int) async throws -> Character
}
