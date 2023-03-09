//
//  PrivatBankCurrencyExchangeProvider.swift
//  Exchange Rates
//
//  Created by Roman K on 03.03.2023.
//

import Foundation

class PrivatBankCurrencyExchangeProvider: CurrencyExchangeRateProviding, CurrencyExchangeRateForDateProviding {
    private let httpRequestMaker: HTTPRequestMaking

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    init(httpRequestMaker: HTTPRequestMaking = HTTPRequestMaker()) {
        self.httpRequestMaker = httpRequestMaker
    }

    func fetchRates(completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateError>) -> Void) {
        let uri = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"

        guard let serviceUrl = URL(string: uri) else {
            completion(.failure(.invalidUrl(uri)))
            return
        }

        httpRequestMaker.send(url: serviceUrl) { (result: Result<[PrivatBankCurrentCurrencyExchangeRate], HTTPRequestError>) in
            switch result {
            case let .success(exchangeRatesResponse):
                let exchangeRates = self.map(response: exchangeRatesResponse)
                completion(.success(exchangeRates))
            case let .failure(error):
                completion(.failure(.invalidResponse(error)))
            }
        }
    }

    func fetchRates(for date: Date, completion: @escaping (Result<[CurrencyExchangeRate], CurrencyExchangeRateError>) -> Void) {
        let uri = "https://api.privatbank.ua/p24api/exchange_rates?json"
        let dateParam = URLQueryItem(name: "date", value: dateFormatter.string(from: date))

        guard let serviceUrl = URL(string: uri)?.appending(queryItems: [dateParam]) else {
            completion(.failure(.invalidUrl(uri)))
            return
        }

        httpRequestMaker.send(url: serviceUrl) { (result: Result<PrivatBankCurrentHistoryExchangeRateResponse, HTTPRequestError>) in
            switch result {
            case let .success(exchangeRatesResponse):
                let exchangeResponse = exchangeRatesResponse.exchangeRate
                let exchangeRates = self.map(response: exchangeResponse)
                completion(.success(exchangeRates))
            case let .failure(error):
                completion(.failure(.invalidResponse(error)))
            }
        }
    }

    private func map(response: [PrivatBankCurrentCurrencyExchangeRate]) -> [CurrencyExchangeRate] {
        response.compactMap { privatExchangeRate in
            guard
                let baseCurrency = CurrencyCode(rawValue: privatExchangeRate.baseCurrency),
                let foreignCurrency = CurrencyCode(rawValue: privatExchangeRate.currency),
                let buying = Double(privatExchangeRate.purchaseRate),
                let selling = Double(privatExchangeRate.saleRate)
            else {
                return nil
            }
            return CurrencyExchangeRate(baseCurrency: baseCurrency,
                                        foreignCurrency: foreignCurrency,
                                        buying: buying,
                                        selling: selling)
        }
    }

    private func map(response: [PrivatBankCurrentHistoryExchangeRate]) -> [CurrencyExchangeRate] {
        response.compactMap { privatExchangeRate in
            guard
                let baseCurrency = CurrencyCode(rawValue: privatExchangeRate.baseCurrency),
                let foreignCurrency = CurrencyCode(rawValue: privatExchangeRate.currency),
                let buying = privatExchangeRate.purchaseRate,
                let selling = privatExchangeRate.saleRate
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

// MARK: - PrivatBankCurrentCurrencyExchangeRate
fileprivate struct PrivatBankCurrentCurrencyExchangeRate: Decodable {
    let currency: String
    let baseCurrency: String
    let purchaseRate: String
    let saleRate: String

    enum CodingKeys: String, CodingKey {
        case currency = "ccy"
        case baseCurrency = "base_ccy"
        case purchaseRate = "buy"
        case saleRate = "sale"
    }
}

// MARK: - PrivatBankCurrentHistoryExchangeRateResponse
fileprivate struct PrivatBankCurrentHistoryExchangeRateResponse: Codable {
    let exchangeRate: [PrivatBankCurrentHistoryExchangeRate]
}

// MARK: - PrivatBankCurrentHistoryExchangeRate
fileprivate struct PrivatBankCurrentHistoryExchangeRate: Codable {
    let baseCurrency: String
    let currency: String
    let saleRate: Double?
    let purchaseRate: Double?
    let saleRateNB: Double
    let purchaseRateNB: Double
}
