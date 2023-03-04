//
//  CurrencyExchangeListItem.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct CurrencyExchangeListItem: View {
    @Binding var item: CurrencyExchangeRate
    
    var body: some View {
        HStack {
            Image(systemName: item.foreignCurrency.imageName)

            VStack(alignment: .leading) {
                Text(item.foreignCurrency.formatted)
                    .font(.headline)
                Text(item.foreignCurrency.name)
                    .font(.subheadline)
            }

            Spacer()

            Text(item.buying.formatted())

            Spacer()

            Text(item.selling.formatted())
        }
    }
}

struct CurrencyExchangeListItem_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeListItem(item: .constant(testCurrencyExchangeRate))
    }
}
