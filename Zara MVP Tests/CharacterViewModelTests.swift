//
//  CharacterViewModelTests.swift
//  Zara MVP Tests
//
//  Created by Alejandro Vinueza on 16/4/24.
//

import XCTest
@testable import Zara_MVP

@MainActor
final class CharacterViewModelTests: XCTestCase {
    var viewModel: CharacterViewModel!
    var mockService: MockCharacterService!
    var mockCache: MockCharacterCache!

    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        mockCache = MockCharacterCache()
        viewModel = CharacterViewModel(characterService: mockService, cacheService: mockCache)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockCache = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testCharactersLoadingSuccess() async {
        await viewModel.loadCharacters()
        XCTAssertTrue(!viewModel.characters.isEmpty)
        XCTAssertEqual(viewModel.characters.count, 20)
        XCTAssertEqual(viewModel.characters.first?.id, 1)
    }

    func testCharactersLoadingFailure() async {
        mockService.shouldReturnError = true
        await viewModel.loadCharacters()
        XCTAssertNotNil(viewModel.error)
    }

    func testLoadCharacterDetailsSuccess() async {
        let expectedCharacter = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", image: "", episode: [], url: "", created: "")
        let character = await viewModel.loadCharacterDetails(characterId: 1)
        XCTAssertEqual(character, expectedCharacter, "The character details should match the expected data.")
    }

    func testLoadCharacterDetailsFailure() async {
        mockService.shouldReturnError = true
        let character = await viewModel.loadCharacterDetails(characterId: 999)
        XCTAssertNil(character, "Character details should be nil after a failed fetch.")
        XCTAssertNotNil(viewModel.error, "Error should be set after a failed fetch.")
    }

    func testCachingOnFetch() async {
        let characters = [Character(id: 1, name: "Morty", status: "Alive", species: "Human", type: "", gender: "Male", image: "", episode: [], url: "", created: "")]
        mockCache.cacheCharacters(characters)
        await viewModel.loadCharactersIfNeeded()
        XCTAssertEqual(mockCache.getCachedCharacters(), characters, "Characters should be cached after fetching.")
    }
}
