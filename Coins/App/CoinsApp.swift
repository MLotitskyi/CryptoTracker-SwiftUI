//
//  CoinsApp.swift
//  Coins
//
//  Created by Максим Лотіцький on 30/01/2026.
//

import SwiftUI

@main
struct CoinsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(service: CoinService())
        }
    }
}
