//
//  ContentView.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CurrentExchangeRateView()
                .tabItem {
                    TabItemCurrent()
                }
            HistoryExchangeRateWrapperView()
                .tabItem {
                    TabItemHistory()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
