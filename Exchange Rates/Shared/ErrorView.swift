//
//  ErrorView.swift
//  Exchange Rates
//
//  Created by Roman K on 06.03.2023.
//

import SwiftUI

struct ErrorView: View {
    var title: String
    var message: String?
    var onRetry: (() -> Void)?

    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            Text(title)
                .font(.title)

            if let message = message {
                Text(message)
                    .font(.title2)
            }

            if let onRetry = onRetry {
                Button("Retry", action: onRetry)
                    .font(.title2)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Oops!",
                  message: "Shit happens!",
                  onRetry: {})
    }
}
