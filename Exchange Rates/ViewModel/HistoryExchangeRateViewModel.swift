//
//  HistoryExchangeRateViewModel.swift
//  Exchange Rates
//
//  Created by Roman K on 07.03.2023.
//

import Foundation

protocol HistoryExchangeRateViewModelable: LoadableObject where ValueType == [CurrencyExchangeRate] {}

class HistoryExchangeRateViewModel: HistoryExchangeRateViewModelable {
    @Published var state: LoadingState<[CurrencyExchangeRate]> = .initial
    let date: Date

    private let currencyExchangeRateProvider: CurrencyExchangeRateForDateProviding

    init(date: Date, currencyExchangeRateProvider: CurrencyExchangeRateForDateProviding = PrivatBankCurrencyExchangeProvider()) {
        self.date = date
        self.currencyExchangeRateProvider = currencyExchangeRateProvider
    }

    func load() {
        state = .loading
        currencyExchangeRateProvider.fetchRates(for: date) { [weak self] result in
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

class MockedHistoryExchangeRateViewModel: HistoryExchangeRateViewModelable {
    @Published var state: LoadingState<[CurrencyExchangeRate]>

    init(state: LoadingState<[CurrencyExchangeRate]> = .initial) {
        self.state = state
    }

    func load() {
        state = .loaded(mockedCurrencyExchangeRates)
    }
}
