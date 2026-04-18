//
//  ImageLoader.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation
import SwiftUI
internal import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: Image?
    
    private let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        Task { await LoadImage() }
    }
    
    @MainActor
    func LoadImage() async {
        
        if let cachedImage = ImageCache.shared.get(forKey: imageUrl) {
            print("DEBUG: Image loaded from cache")
            self.image = Image(uiImage: cachedImage)
            return
        }
        
        guard let endpoint = URL(string: imageUrl) else { return }
        
        guard let (data, _) = try? await URLSession.shared.data(from: endpoint) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        print("DEBUG: Image loaded from API")
        ImageCache.shared.set(uiImage, forKey: imageUrl)
        self.image = Image(uiImage: uiImage)
    }
}
