//
//  ContactsView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

//import SwiftUI
//import ComposableArchitecture
//
//struct ContactsView: View {
//    
//    @Bindable
//    var store: StoreOf<ContactsReducer>
//    
//    var body: some View {
//        NavigationStack {
//            List(store.contacts) { contact in
//                Text(contact.name)
//            }
//            .navigationTitle("Contacts")
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        store.send(.addButtonTapped)
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            } // toolbar
//        } // NavigationStack
//        // 스코프를 통해 state, action 을 지정한 store 를 클로저에서 쓸 수 있게 함
//        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactStore in
//            NavigationStack {
//                AddContactView(store: addContactStore) // 단순히 띄워질 뷰 역할
//            }
//        }
//    }
//}
//
//
//#Preview {
//    ContactsView(
//        store: Store(
//            initialState: ContactsReducer.State(
//                contacts: [
//                    Contact(name: "youngjoo1"),
//                    Contact(name: "youngjoo2"),
//                    Contact(name: "youngjoo3"),
//                ]
//            )
//        ) {
//            ContactsReducer()
//        }
//    )
//}

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    
    @Bindable var store: StoreOf<ContactsReducer>
    
    var body: some View {
        NavigationStack {
            // 의문점 왜 여기서 ObservableState 가 필요한가요,,
            List(store.contacts) { contact in
                Text(contact.name)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.pulsButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactStore in
                AddContactView(store: addContactStore)
            }
        }
        
    }
}
