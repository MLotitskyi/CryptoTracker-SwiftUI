//
//  CoinDetailsView.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import SwiftUI

struct CoinDetailsView: View {
    @StateObject private var viewModel: CoinDetailsViewModel
    private var coin: Coin
    
    init(coin: Coin, service: CoinServiceProtocol) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: CoinDetailsViewModel(coinId: coin.id, service: service))
    }
    
    var body: some View {
        VStack {
            if let coinDetails = viewModel.coinDetails {
                HStack {
                    VStack(alignment: .leading) {
                        Text(coinDetails.name)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text(coinDetails.symbol.uppercased())
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    ImageView(imageUrl: coin.image)
                        .frame(width: 64, height: 64)
                }
                
                Text(coinDetails.description.text)
                    .padding(.vertical)
                    .font(.footnote)
            }
        }
        .task {
            await self.viewModel.fetchCoinDetails()
        }
        .padding()
    }
}

//#Preview {
//    CoinDetailsView()
//}
