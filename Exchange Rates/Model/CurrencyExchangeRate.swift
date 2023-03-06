//
//  CurrencyExchangeRate.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import Foundation

enum CurrencyCode: String {
    case usd = "USD"
    case uah = "UAH"
    case eur = "EUR"
    case other

    var formatted: String {
        return self.rawValue
    }

    var name: String {
        switch self {
        case .usd: return "US dollar"
        case .uah: return "Ukrainian hryvnia"
        case .eur: return "Euro"
        case .other: return ""
        }
    }

    var imageName: String {
        switch self {
        case .usd: return "dollarsign.circle"
        case .uah: return "hryvniasign.circle"
        case .eur: return "eurosign.circle"
        case .other: return "coloncurrencysign.circle"
        }
    }
}

struct CurrencyExchangeRate: Identifiable {
    let id: UUID = UUID()
    let baseCurrency: CurrencyCode
    let foreignCurrency: CurrencyCode
    let buying: Double
    let selling: Double
}

let mockedCurrencyExchangeRate = CurrencyExchangeRate(baseCurrency: .uah,
                                                    foreignCurrency: .usd,
                                                    buying: 12.3456,
                                                    selling: 12.3456)

let mockedCurrencyExchangeRates: [CurrencyExchangeRate] = [
    CurrencyExchangeRate(baseCurrency: .uah, foreignCurrency: .usd, buying: 12.3456, selling: 12.3456),
    CurrencyExchangeRate(baseCurrency: .uah, foreignCurrency: .eur, buying: 12.3456, selling: 12.3456)
]
