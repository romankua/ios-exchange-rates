//
//  LoadableObjectView.swift
//  Exchange Rates
//
//  Created by Roman K on 07.03.2023.
//

import SwiftUI

struct LoadableObjectView<ViewModel: LoadableObject, Content: View, ErrorContent: View>: View {
    @ObservedObject var viewModel: ViewModel
    var content: (ViewModel.ValueType) -> Content
    var errorContent: (Error) -> ErrorContent
    
    var body: some View {
        switch viewModel.state {
        case .initial:
            Color.clear.onAppear(perform: load)
        case .loading:
            ProgressView()
        case let .loaded(value):
            content(value)
        case let .failed(error):
            errorContent(error)
        }
    }

    init(viewModel: ViewModel,
         @ViewBuilder content: @escaping (ViewModel.ValueType) -> Content,
         @ViewBuilder errorContent: @escaping (Error) -> ErrorContent) {
        self.viewModel = viewModel
        self.content = content
        self.errorContent = errorContent
    }

    private func load() {
        viewModel.load()
    }
}
