//
//  CurrentExchangeRateViewModel.swift
//  Exchange Rates
//
//  Created by Roman K on 02.03.2023.
//

import Foundation

protocol CurrentExchangeRateViewModelable: LoadableObject {
    var state: LoadingState<[CurrencyExchangeRate]> { get }
}

class CurrentExchangeRateViewModel: CurrentExchangeRateViewModelable {
    @Published var state: LoadingState<[CurrencyExchangeRate]> = .initial

    private let privatBankCurrencyExchangeProvider = PrivatBankCurrencyExchangeProvider()

    func load() {
        state = .loading
        privatBankCurrencyExchangeProvider.fetchRates { [weak self] result in
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

    init(state: LoadingState<[CurrencyExchangeRate]>) {
        self.state = state
    }
    
    func load() {
        state = .loaded(mockedCurrencyExchangeRates)
    }
}
