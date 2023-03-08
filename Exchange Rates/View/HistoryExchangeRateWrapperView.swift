//
//  HistoryExchangeRateWrapperView.swift
//  Exchange Rates
//
//  Created by Roman K on 08.03.2023.
//

import SwiftUI

struct HistoryExchangeRateWrapperView: View {
    @State private var date: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    
    var body: some View {
        VStack {
            DatePicker("Choose date", selection: $date, displayedComponents: .date)

            HistoryExchangeRateView(viewModel: HistoryExchangeRateViewModel(date: date))
        }
        .padding()
    }
}

struct HistoryExchangeRateWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryExchangeRateWrapperView()
    }
}
