//
//  CurrentExchangeRateView.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct CurrentExchangeRateView: View {
    @ObservedObject var viewModel = CurrentExchangeRateViewModel()

    var body: some View {
        VStack {
//            CurrencyExchangeList(items: $viewModel.rates)
//                .listStyle(.plain)
            CurrencyExchangeGrid(items: $viewModel.rates)
        }
        .padding()
        .refreshable {
            viewModel.fetch()
        }
    }
}

struct CurrentExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentExchangeRateView()
    }
}
