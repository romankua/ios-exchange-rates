//
//  HistoryExchangeRateWrapperView.swift
//  Exchange Rates
//
//  Created by Roman K on 08.03.2023.
//

import SwiftUI

struct HistoryExchangeRateWrapperView: View {
    @State private var date: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @State private var dateSelected: Bool = false

    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .year, value: -5, to: Date())!
        let endDate = calendar.date(byAdding: .day, value: -1, to: Date())!
        return startDate...endDate
    }()
    
    var body: some View {
        VStack {
            DatePicker("Choose date",
                       selection: $date,
                       in: dateRange,
                       displayedComponents: [.date])
                .datePickerStyle(.graphical)

            if dateSelected {
                HistoryExchangeRateView(viewModel: HistoryExchangeRateViewModel(date: date))
            }

            Spacer()
        }
        .padding()
        .onChange(of: date) { _ in
            dateSelected = true
        }
    }
}

struct HistoryExchangeRateWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryExchangeRateWrapperView()
    }
}
