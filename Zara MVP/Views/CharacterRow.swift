//
//  CharacterRow.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(25)
            VStack(alignment: .leading) {
                Text(character.name).font(.zaraBody)
                    .foregroundColor(.zaraPrimary)
                Text("\(character.species), \(character.status)").font(.zaraBody)
                    .foregroundColor(Color.zaraSecondary)
            }
        }
    }
}

#Preview {
    let sampleCharacter = Character(
        id: 2,
        name: "Morty Smith",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/2",
        created: "2017-11-04T18:50:21.651Z"
    )
    return CharacterRow(character: sampleCharacter)
        .previewLayout(.sizeThatFits)
}
