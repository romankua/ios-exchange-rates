//
//  CurrencyExchangeRateProviding.swift
//  Exchange Rates
//
//  Created by Roman K on 03.03.2023.
//

import Foundation

enum CurrencyExchangeRateError: Error {
    case invalidUrl(String)
    case invalidResponse(Error)
}

protocol CurrencyExchangeRateProviding {
    func fetchRates(completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateError>) -> Void)
}

protocol CurrencyExchangeRateForDateProviding {
    func fetchRates(for: Date, completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateError>) -> Void)
}
