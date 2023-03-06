//
//  CurrencyExchangeGridRow.swift
//  Exchange Rates
//
//  Created by Roman K on 02.03.2023.
//

import SwiftUI

struct CurrencyExchangeGridRow: View {
    var item: CurrencyExchangeRate

    var body: some View {
        HStack {
            Image(systemName: item.foreignCurrency.imageName)
                .font(.title)

            VStack(alignment: .leading) {
                Text(item.foreignCurrency.formatted)
                    .font(.headline)
                Text(item.foreignCurrency.name)
                    .font(.subheadline)
            }
        }

        Text(String(format: "%.2f", item.buying))

        Text(String(format: "%.2f", item.selling))
    }
}

struct CurrencyExchangeGridRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeGridRow(item: mockedCurrencyExchangeRate)
    }
}
