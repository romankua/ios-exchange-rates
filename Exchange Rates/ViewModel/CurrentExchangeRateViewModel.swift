//
//  CurrentExchangeRateViewModel.swift
//  Exchange Rates
//
//  Created by Roman K on 02.03.2023.
//

import Foundation

class CurrentExchangeRateViewModel: ObservableObject {
    @Published var rates: [CurrencyExchangeRate] = []

    private let privatBankCurrencyExchangeProvider = PrivatBankCurrencyExchangeProvider()

    init() {
        fetch()
    }

    func fetch() {
        privatBankCurrencyExchangeProvider.fetchRates { [weak self] result in
            switch result {
            case let .success(currencyExchangeRate):
                DispatchQueue.main.async {
                    self?.rates = currencyExchangeRate
                }
            case let .failure(error):
                print("Exchange rates loading failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.rates = []
                }
            }
        }
    }
}
