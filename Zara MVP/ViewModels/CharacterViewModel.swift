//
//  CharacterViewModel.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var error: AppError?

    private var currentPage = 1
    private var totalPages = 1
    private var characterService: CharacterServiceProtocol
    private var cacheService: CharacterCaching

    init(characterService: CharacterServiceProtocol, cacheService: CharacterCaching) {
        self.characterService = characterService
        self.cacheService = cacheService
    }

    func loadCharactersIfNeeded() async {
        if !characters.isEmpty { return }

        let cachedCharacters = cacheService.getCachedCharacters()
        if !cachedCharacters.isEmpty {
            self.characters = cachedCharacters
            return
        }

        await loadCharacters()
    }

    func loadCharacters() async {
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true

        do {
            let response = try await characterService.fetchCharacters(page: currentPage)
            cacheService.cacheCharacters(response.results)
            characters.append(contentsOf: response.results)
            totalPages = response.info.pages
            currentPage += 1
        } catch let error as AppError {
            self.error = error
        } catch {
            self.error = AppError.unknown(description: "An unexpected error occurred.")
        }

        isLoading = false
    }


    func loadCharacterDetails(characterId: Int) async -> Character? {
        isLoading = true

        do {
            let character = try await characterService.fetchCharacterById(characterId)
            isLoading = false
            return character
        } catch let error as AppError {
            self.error = error
        } catch {
            self.error = AppError.unknown(description: "An unexpected error occurred.")
        }

        isLoading = false
        return nil
    }
}

