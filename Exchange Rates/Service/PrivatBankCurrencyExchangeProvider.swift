//
//  PrivatBankCurrencyExchangeProvider.swift
//  Exchange Rates
//
//  Created by Roman K on 03.03.2023.
//

import Foundation

class PrivatBankCurrencyExchangeProvider: CurrencyExchangeRateProviding {
    private let uri = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"

    func fetchRates(completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateProvidingError>) -> Void) {
        guard let serviceUrl = URL(string: uri) else {
            completion(.failure(.invalidUrl(uri)))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: serviceUrl) { data, response, error in
            if let error = error {
                completion(.failure(.forwarded(error)))
                return
            }

            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                completion(.failure(.invalidResponse(serviceUrl)))
                return
            }

            guard let responseData = data else {
                completion(.failure(.invalidResponse(serviceUrl)))
                return
            }

            let decoder = JSONDecoder()
            do {
                let exchangeResponse = try decoder.decode([PrivatBankCurrencyExchangeRate].self, from: responseData)
                let exchangeRates = self.map(response: exchangeResponse)
                completion(.success(exchangeRates))
            } catch let error {
                completion(.failure(.forwarded(error)))
            }
        }

        dataTask.resume()
    }

    private func map(response: [PrivatBankCurrencyExchangeRate]) -> [CurrencyExchangeRate] {
        response.compactMap { privatExchangeRate in
            guard
                let baseCurrency = CurrencyCode(rawValue: privatExchangeRate.base_ccy),
                let foreignCurrency = CurrencyCode(rawValue: privatExchangeRate.ccy),
                let buying = Double(privatExchangeRate.buy),
                let selling = Double(privatExchangeRate.sale)
            else {
                return nil
            }
            return CurrencyExchangeRate(baseCurrency: baseCurrency,
                                        foreignCurrency: foreignCurrency,
                                        buying: buying,
                                        selling: selling)
        }
    }
}

fileprivate struct PrivatBankCurrencyExchangeRate: Decodable {
    let ccy: String
    let base_ccy: String
    let buy: String
    let sale: String
}
