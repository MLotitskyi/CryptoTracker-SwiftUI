//
//  Coin.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

struct Coin: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let symbol: String
    
    let marketCapRank: Int
    let currentPrice: Double
    
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case marketCapRank = "market_cap_rank"
        case currentPrice = "current_price"
    }
}
