//
//  ImageCache.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import SwiftUI

class ImageCache {
    
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func set(_ uiImage: UIImage, forKey key: String) {
        cache.setObject(uiImage as UIImage, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
