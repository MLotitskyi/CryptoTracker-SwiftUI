//
//  AllCoinsViewModel.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation
internal import Combine

class AllCoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    private var service: CoinServiceProtocol
    
    init(service: CoinServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchCoins() async {
        do {
            let newCoins = try await service.fetcCoins()
            coins.append(contentsOf: newCoins)
        } catch {
            let coinError = error as? CoinError ?? .unknownError(description: error.localizedDescription)
            errorMessage = coinError.customDescription
        }
    }
}
