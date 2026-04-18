//
//  CoinDetails.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

struct CoinDetails: Identifiable, Codable {
    let id: String
    let name: String
    let symbol: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
