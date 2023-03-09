//
//  CurrentExchangeRateViewModel.swift
//  Exchange Rates
//
//  Created by Roman K on 02.03.2023.
//

import Foundation

protocol CurrentExchangeRateViewModelable: LoadableObject where ValueType == [CurrencyExchangeRate] {}

class CurrentExchangeRateViewModel: CurrentExchangeRateViewModelable {
    @Published var state: LoadingState<[CurrencyExchangeRate]> = .initial

    private let currencyExchangeRateProvider: CurrencyExchangeRateProviding

    init(currencyExchangeRateProvider: CurrencyExchangeRateProviding = PrivatBankCurrencyExchangeProvider()) {
        self.currencyExchangeRateProvider = currencyExchangeRateProvider
    }

    func load() {
        state = .loading
        currencyExchangeRateProvider.fetchRates { [weak self] result in
            switch result {
            case let .success(currencyExchangeRate):
                DispatchQueue.main.async {
                    self?.state = .loaded(currencyExchangeRate)
                }
            case let .failure(error):
                print("Exchange rates loading failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
}

class MockedCurrentExchangeRateViewModel: CurrentExchangeRateViewModelable {
    @Published var state: LoadingState<[CurrencyExchangeRate]>

    init(state: LoadingState<[CurrencyExchangeRate]> = .initial) {
        self.state = state
    }
    
    func load() {
        state = .loaded(mockedCurrencyExchangeRates)
    }
}
