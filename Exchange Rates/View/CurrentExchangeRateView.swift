//
//  CurrentExchangeRateView.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct CurrentExchangeRateView<ViewModel: CurrentExchangeRateViewModelable>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            LoadableObjectView(viewModel: viewModel) { rates in
                CurrencyExchangeGrid(items: rates)
            } errorContent: { error in
                ErrorView(title: "Oops, error happened!",
                          message: error.localizedDescription,
                          onRetry: viewModel.load)
            }
        }
        .padding()
        .refreshable { viewModel.load() }
    }

    init(viewModel: ViewModel = CurrentExchangeRateViewModel()) {
        self.viewModel = viewModel
    }
}

struct CurrentExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentExchangeRateView(viewModel: MockedCurrentExchangeRateViewModel())
//        CurrentExchangeRateView(viewModel: MockedCurrentExchangeRateViewModel(state: .failed(URLLoadingError.invalidUrl("abc"))))
    }
}
