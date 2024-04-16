//
//  Zara_MVPApp.swift
//  Zara MVP
//
//  Created by Alejandro Vinueza on 16/4/24.
//

import SwiftUI

@main
struct Zara_MVPApp: App {
    private let characterService = NetworkManager()
    private let cacheService = AdvancedCharacterCache()

    var body: some Scene {
        WindowGroup {
            if CommandLine.arguments.contains("--uitesting") {
                CharactersListView(viewModel: CharacterViewModel(characterService: MockCharacterService(shouldReturnError: ProcessInfo.processInfo.environment["TEST_SCENARIO"] == "LOAD_ERROR"), cacheService: MockCharacterCache()))
            } else {
                CharactersListView(viewModel: CharacterViewModel(characterService: characterService, cacheService: cacheService))
            }
        }
    }
}
