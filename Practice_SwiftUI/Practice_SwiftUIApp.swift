//
//  Practice_SwiftUIApp.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/10/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct Practice_SwiftUIApp: App {
    
    private static let counterStore = Store(initialState: CounterReducer.State()) {
        CounterReducer()
            ._printChanges()
    }
    
    private static let counterAppStore = Store(initialState: CounterAppReducer.State()) {
        CounterAppReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
//            CounterView(store: Practice_SwiftUIApp.counterStore)
            CounterMainTabView(store: Practice_SwiftUIApp.counterAppStore)
        }
    }
}
