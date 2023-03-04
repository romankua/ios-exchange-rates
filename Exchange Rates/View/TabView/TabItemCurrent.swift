//
//  TabItemCurrent.swift
//  Exchange Rates
//
//  Created by Roman K on 01.03.2023.
//

import SwiftUI

struct TabItemCurrent: View {
    var body: some View {
        Label("Current", systemImage: "coloncurrencysign.circle")
            .font(.largeTitle)
    }
}

struct TabViewItemCurrent_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Text("Some")
                .tabItem {
                    TabItemCurrent()
                }
        }
    }
}
