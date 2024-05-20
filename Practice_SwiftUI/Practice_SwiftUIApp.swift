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
    
    private static let contactsStore = Store(
        initialState: ContactsReducer.State(
            contacts: [
                Contact(name: "youngjoo1"),
                Contact(name: "youngjoo2"),
                Contact(name: "youngjoo3"),
            ]
        )
    ) {
        ContactsReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
//            CounterView(store: Practice_SwiftUIApp.counterStore)
            CounterMainTabView(counterStore: Practice_SwiftUIApp.counterAppStore, contactsStore: Practice_SwiftUIApp.contactsStore)
//            ContactsView(store: Practice_SwiftUIApp.ContactsStore)
        }
    }
}
