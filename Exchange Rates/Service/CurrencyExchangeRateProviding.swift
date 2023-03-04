//
//  CurrencyExchangeRateProviding.swift
//  Exchange Rates
//
//  Created by Roman K on 03.03.2023.
//

import Foundation

enum CurrencyExchangeRateProvidingError: Error {
    case invalidUrl(String)
    case invalidResponse(URL)
    case forwarded(Error)
}

protocol CurrencyExchangeRateProviding {
    func fetchRates(completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateProvidingError>) -> Void)
}
