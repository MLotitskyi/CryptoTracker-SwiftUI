//
//  CoinService.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

protocol CoinServiceProtocol {
    func fetcCoins() async throws -> [Coin]
    func fetchCoinDetails(forId id: String) async throws -> CoinDetails?
}

class CoinService: CoinServiceProtocol, HTTPDataDownloader {
    
    private var page: Int = 0
    private var numberPerPage: Int = 50
    
    func fetcCoins() async throws -> [Coin] {
        self.page += 1
        
        guard let endpoint = self.allCoinsUrl else {
            throw CoinError.requestFailed(description: "Invalid endpoint")
        }
        
        return try await self.fetchData(as: [Coin].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(forId id: String) async throws -> CoinDetails? {
        if let cachedCoinDetails = CoinDetailsCache.shared.get(forKey: id) {
            print("DEBUG: Coin details were fetched from cache")
            return cachedCoinDetails
        }
        
        guard let endpoint = self.coinDetailsUrl(forId: id) else {
            throw CoinError.requestFailed(description: "Invalid endpoint")
        }
        
        let data = try await self.fetchData(as: CoinDetails.self, endpoint: endpoint)
        print("DEBUG: Coin details were fetched from API")
        CoinDetailsCache.shared.set(coinDetails: data, forKey: id)
        return data
    }
    
    private var baseUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
    }
    
    private var allCoinsUrl: String? {
        var components = baseUrl
        components.path += "markets"
        
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "price_change_percentage", value: "24h"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "page", value: "\(self.page)"),
            .init(name: "per_page", value: "\(self.numberPerPage)")
        ]

        return components.url?.absoluteString
    }
    
    private func coinDetailsUrl(forId id: String) -> String? {
        var components = baseUrl
        components.path += "\(id)"
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return components.url?.absoluteString
    }
}
