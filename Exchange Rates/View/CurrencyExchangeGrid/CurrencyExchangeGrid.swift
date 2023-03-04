//
//  CurrencyExchangeGrid.swift
//  Exchange Rates
//
//  Created by Roman K on 02.03.2023.
//

import SwiftUI

struct CurrencyExchangeGrid: View {
    @Binding var items: [CurrencyExchangeRate]

    private let columns = [
        GridItem(alignment: .leading),
        GridItem(alignment: .trailing),
        GridItem(alignment: .trailing)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                CurrencyExchangeGridHeader()

                ForEach($items) { item in
                    CurrencyExchangeGridRow(item: item)
                }
            }
        }
    }
}

struct CurrencyExchangeGrid_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeGrid(items: .constant(testCurrencyExchangeRates))
    }
}
