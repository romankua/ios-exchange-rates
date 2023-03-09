//
//  Basis.swift
//  Exchange Rates
//
//  Created by Roman K on 06.03.2023.
//

import Foundation

/// Defines ObservableObject that has state
protocol StatefulObject: ObservableObject {
    associatedtype State
    /// Provides object's current state. Implement state as @Published to observe state changes
    var state: State { get set}
}

/// States to use with loadable object
enum LoadingState<ValueType> {
    case initial
    case loading
    case failed(Error)
    case loaded(ValueType)
}

/// Loadable object that knows how to fetch data of ValueType
protocol LoadableObject: StatefulObject {
    associatedtype ValueType
    var state: LoadingState<ValueType> { get }
    func load()
}
