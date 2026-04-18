//
//  HTTPDataDownloader.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw CoinError.requestFailed(description: "Invalid endpoint...")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw CoinError.requestFailed(description: "Invalid response...")
        }
        
        guard response.statusCode == 200 else {
            throw CoinError.invalidStatusCode(statusCode: response.statusCode)
        }
        
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            throw error as? CoinError ?? CoinError.unknownError(description: error.localizedDescription)
        }
    }
}
