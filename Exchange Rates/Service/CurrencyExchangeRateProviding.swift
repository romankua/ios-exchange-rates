//
//  CurrencyExchangeRateProviding.swift
//  Exchange Rates
//
//  Created by Roman K on 03.03.2023.
//

import Foundation

protocol CurrencyExchangeRateProviding {
    func fetchRates(completion: @escaping (Result<[CurrencyExchangeRate], URLLoadingError>) -> Void)
}
