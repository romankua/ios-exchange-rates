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
            switch viewModel.state {
            case .initial:
                Color.clear.onAppear(perform: load)
            case .loading:
                ProgressView()
            case let .loaded(rates):
                CurrencyExchangeGrid(items: rates)
            case let .failed(error):
                ErrorView(title: "Oops, error happened!",
                          message: error.localizedDescription,
                          retryHandler: load)
            }
        }
        .padding()
        .refreshable { load() }
    }

    init(viewModel: ViewModel = CurrentExchangeRateViewModel()) {
        self.viewModel = viewModel
    }

    private func load() {
        viewModel.load()
    }
}

struct CurrentExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentExchangeRateView(viewModel: MockedCurrentExchangeRateViewModel(state: .failed(URLLoadingError.invalidUrl("abc"))))
    }
}
