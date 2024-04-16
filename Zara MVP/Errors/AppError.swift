//
//  AppError.swift
//  Zara Rick Morty
//
//  Created by Alejandro Vinueza on 15/4/24.
//

import Foundation

enum AppError: Error, LocalizedError, Identifiable {
    case network(description: String)
    case decoding(description: String)
    case invalidURL(description: String)
    case unknown(description: String)

    var id: String {
        switch self {
        case .network(let description):
            return "network-\(description)"
        case .decoding(let description):
            return "decoding-\(description)"
        case .invalidURL(let description):
            return "invalidURL-\(description)"
        case .unknown(let description):
            return "unknown-\(description)"
        }
    }

    var errorDescription: String? {
        switch self {
        case .network(let description):
            return "Network error: \(description)"
        case .decoding(let description):
            return "Decoding error: \(description)"
        case .invalidURL(let description):
            return "Invalid URL: \(description)"
        case .unknown(let description):
            return "Unknown error: \(description)"
        }
    }
}
