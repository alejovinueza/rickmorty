//
//  CharactersListView.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel: CharacterViewModel

    var body: some View {
        NavigationView {
            List(viewModel.characters, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: viewModel, characterId: character.id)) {
                    CharacterRow(character: character)
                }
                .onAppear {
                    if character == viewModel.characters.last {
                        Task {
                            await viewModel.loadCharacters()
                        }
                    }
                }
            }
            .accessibilityIdentifier("CharactersList")
            .navigationTitle("Rick and Morty Characters")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .accessibilityIdentifier("In progress")
                    }
                }, alignment: .center
            )
            .onAppear {
                Task {
                    await viewModel.loadCharactersIfNeeded()
                }
            }
        }
    }
}

#Preview {
    let viewModel = CharacterViewModel(characterService: MockCharacterService(), cacheService: MockCharacterCache())
    return CharactersListView(viewModel: viewModel)
        .onAppear {
            Task {
                await viewModel.loadCharacters()
            }
        }
}
