//
//  CounterTabView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

//import SwiftUI
//import ComposableArchitecture
//
//struct CounterMainTabView: View {
//    
//    // 독립된 스토어들을 가지는 대신 단일 스토어에 의해 뷰가 구동되도록 선호
//    let store: StoreOf<CounterAppReducer>
//    
//    var body: some View {
//        TabView {
//            CounterView(store: store.scope(state: \.tab1.tab1, action: \.tab1))
//                .tabItem {
//                    Text("1")
//                }
//            
//            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
//                .tabItem {
//                    Text("2")
//                }
//        }
//    }
//}
//
//#Preview {
//    CounterMainTabView(store: Store(initialState: CounterAppReducer.State()) {
//        CounterAppReducer()
//    })
//}

import SwiftUI
import ComposableArchitecture

struct CounterMainTabView: View {
    
    // reducer 를 하나로 묶어서 모듈화해서 사용하는 것 vs 각 화면을 각 reducer 로 사용하는 것
    // 이것 또한 어떻게 사용해야할까..
    let counterStore: StoreOf<CounterAppReducer>
    let contactsStore: StoreOf<ContactsReducer>
    
    var body: some View {
        TabView {
            CounterView(store: counterStore.scope(state: \.tab1, action: \.tab1)) // 해당 스토어에 있는 state, action 을 사용하겠다.
                .tabItem {
                    Image(systemName: "star")
                    Text("Counter1")
                }
            
            CounterView(store: counterStore.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Image(systemName: "star")
                    Text("Counter2")
                }
            
            ContactsView(store: contactsStore)
                .tabItem {
                    Image(systemName: "star")
                    Text("Contacts3")
                }
        }
        
    }
}
