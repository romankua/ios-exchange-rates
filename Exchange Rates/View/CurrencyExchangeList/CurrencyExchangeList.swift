//
//  CurrencyExchangeList.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct CurrencyExchangeList: View {
    @Binding var items: [CurrencyExchangeRate]

    var body: some View {
        List {
            ForEach($items) { item in
                CurrencyExchangeListItem(item: item)
            }
        }
    }
}

struct CurrencyExchangeList_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeList(items: .constant(testCurrencyExchangeRates))
    }
}
