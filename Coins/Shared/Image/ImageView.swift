//
//  ImageView.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import SwiftUI

struct ImageView: View {
    private let imageUrl: String
    @StateObject var imageLoader: ImageLoader
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        _imageLoader = StateObject(wrappedValue: ImageLoader(imageUrl: imageUrl))
    }
    
    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}

//#Preview {
//    ImageView()
//}
