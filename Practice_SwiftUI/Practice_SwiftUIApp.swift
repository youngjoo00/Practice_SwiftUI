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
    
    private static let counterStore = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: Practice_SwiftUIApp.counterStore)
        }
    }
}
