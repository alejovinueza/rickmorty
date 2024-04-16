//
//  MockCharacterService.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

class MockCharacterService: CharacterServiceProtocol {
    var shouldReturnError = false

    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }

    func fetchCharacters(page: Int) async throws -> CharacterResponse {
        if shouldReturnError {
            throw AppError.network(description: "Failed to fetch characters.")
        }
        
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let resultsPerPage = 20
        var characters = [Character]()
        for index in 1...resultsPerPage {
            let character = Character(
                id: index,
                name: "Character \(index + (resultsPerPage * (page - 1)))",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                image: "https://example.com/image\(index).jpg",
                episode: ["https://example.com/episode1"],
                url: "https://example.com/character\(index)",
                created: "2021-01-01T00:00:00.000Z"
            )
            characters.append(character)
        }

        let totalPages = 5
        return CharacterResponse(info: Info(count: 100, pages: totalPages, next: page < totalPages ? "NextPageURL" : nil, prev: page > 1 ? "PrevPageURL" : nil), results: characters)
    }

    func fetchCharacterById(_ id: Int) async throws -> Character {
        if shouldReturnError {
            throw AppError.network(description: "Failed to fetch characters.")
        }

        try await Task.sleep(nanoseconds: 2_000_000_000)
        return Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", image: "", episode: [], url: "", created: "")
    }
}
