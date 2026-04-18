//
//  CoinDetailsViewModel.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import Foundation
internal import Combine

class CoinDetailsViewModel: ObservableObject {
    
    @Published var coinDetails: CoinDetails?
    @Published var errorMessage: String?
    
    private let service: CoinServiceProtocol
    private let coinId: String
    
    init(coinId: String, service: CoinServiceProtocol) {
        self.service = service
        self.coinId = coinId
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            self.coinDetails = try await service.fetchCoinDetails(forId: self.coinId)
        } catch {
            let coinError = error as? CoinError ?? .unknownError(description: error.localizedDescription)
            self.errorMessage = coinError.customDescription
        }
    }
}
