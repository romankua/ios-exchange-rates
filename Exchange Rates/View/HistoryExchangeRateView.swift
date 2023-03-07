//
//  HistoryExchangeRateView.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct HistoryExchangeRateView<ViewModel: HistoryExchangeRateViewModelable>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var date: Date = Date()

    var body: some View {
        VStack {
            DatePicker("Choose date", selection: $date, displayedComponents: .date)

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
        .onChange(of: date) { newValue in
            viewModel.date = date
            viewModel.load()
        }
    }

    init(viewModel: ViewModel = HistoryExchangeRateViewModel()) {
        self.viewModel = viewModel
    }
}

struct HistoryExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryExchangeRateView(viewModel: MockedHistoryExchangeRateViewModel())
    }
}
