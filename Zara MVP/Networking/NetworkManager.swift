//
//  NetworkManager.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

struct NetworkManager: CharacterServiceProtocol {
    private let urlSession = URLSession.shared
    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(page: Int = 1) async throws -> CharacterResponse {
        var urlString = "\(baseURL)?page=\(page)"
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL(description: "The provided page number \(page) created an invalid URL.")
        }
        do {
            let (data, response) = try await urlSession.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw AppError.network(description: "Unexpected response status: \(response)")
            }

            return try JSONDecoder().decode(CharacterResponse.self, from: data)
        } catch {
            throw AppError.decoding(description: "Failed to decode the response.")
        }
    }

    func fetchCharacterById(_ id: Int) async throws -> Character {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw AppError.invalidURL(description: "The provided id \(id) created an invalid URL.")
        }

        do {

            let (data, response) = try await urlSession.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw AppError.network(description: "Unexpected response status: \(response)")
            }

            return try JSONDecoder().decode(Character.self, from: data)
        } catch {
            throw AppError.decoding(description: "Failed to decode the response.")
        }
    }
}
