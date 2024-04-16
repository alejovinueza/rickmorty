//
//  CharacterResponse.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
