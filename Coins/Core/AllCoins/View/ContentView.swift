//
//  ContentView.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: AllCoinsViewModel
    private var service: CoinServiceProtocol
    
    init(service: CoinServiceProtocol) {
        self.service = service
        _viewModel = StateObject(wrappedValue: AllCoinsViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
                            
                            ImageView(imageUrl: coin.image)
                                .frame(width: 32, height: 32)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.bold)
                                    
                                Text(coin.symbol.uppercased())
                            }
                        }
                        .onAppear {
                            if coin == viewModel.coins.last {
                                Task { await viewModel.fetchCoins() }
                                print("DEBUG: Fetched another 50 coins")
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetailsView(coin: coin, service: service)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .task {
            await viewModel.fetchCoins()
        }
    }
}

#Preview {
    ContentView(service: CoinService())
}
