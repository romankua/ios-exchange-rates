//
//  TabItemHistory.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct TabItemHistory: View {
    var body: some View {
        Label("History", systemImage: "calendar.circle")
            .font(.largeTitle)
    }
}

struct TabItemHistory_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Text("Some")
                .tabItem {
                    TabItemHistory()
                }
        }
    }
}
