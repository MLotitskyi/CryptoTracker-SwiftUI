//
//  CoinDetailsCache.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation

class CoinDetailsCache {
    
    static let shared = CoinDetailsCache()
    
    private var cache = NSCache<NSString, NSData>()
    
    func set(coinDetails: CoinDetails, forKey key: String) {
        guard let data = try? JSONEncoder().encode(coinDetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> CoinDetails? {
        guard let data = cache.object(forKey: key as NSString) as? Data else { return nil }
        return try? JSONDecoder().decode(CoinDetails.self, from: data)
    }
    
}
