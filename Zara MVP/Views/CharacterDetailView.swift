//
//  CharacterDetailView.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterViewModel
    let characterId: Int
    @State private var characterDetails: Character?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let character = characterDetails {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 300, height: 300)
                        .cornerRadius(15)
                        .shadow(radius: 10)

                        Text(character.name)
                            .font(.zaraTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.zaraPrimary)

                        DetailRow(label: "Status:", value: character.status)
                        DetailRow(label: "Species:", value: character.species)
                        DetailRow(label: "Gender:", value: character.gender)
                    }
                    .padding()
                    .background(Color.zaraBackground)
                }
            } else if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                Text("Unable to load character details.")
            }
        }
        .accessibilityIdentifier("CharacterDetailView")
        .navigationTitle("Character Details")
        .background(Color.zaraBackground)
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            Task {
                characterDetails = await viewModel.loadCharacterDetails(characterId: characterId)
            }
        }
    }

    struct DetailRow: View {
        var label: String
        var value: String

        var body: some View {
            HStack {
                Text(label)
                    .foregroundColor(.zaraSecondary)
                    .font(.zaraBody)
                Spacer()
                Text(value)
                    .foregroundColor(.zaraPrimary)
                    .font(.zaraBody)
            }
        }
    }
}

#Preview {
    let service = MockCharacterService()
    let cache = MockCharacterCache()
    let viewModel = CharacterViewModel(characterService: service, cacheService: cache)

    let characterId = 1

    return CharacterDetailView(viewModel: viewModel, characterId: characterId)
}
