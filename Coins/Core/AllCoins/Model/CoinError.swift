//
//  CoinError.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

enum CoinError: Error {
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(description: String)
    
    var customDescription: String {
        switch self {
        case .requestFailed(let description):
            return "ERROR: Request failed: \(description)"
        case .invalidStatusCode(let statusCode):
            return "ERROR: Invalid status code: \(statusCode)"
        case .unknownError(let description):
            return "ERROR: Unknown error: \(description)"
        }
    }
}
