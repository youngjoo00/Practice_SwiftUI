//
//  CounterTabView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

import SwiftUI
import ComposableArchitecture

struct CounterMainTabView: View {
    
    // 독립된 스토어들을 가지는 대신 단일 스토어에 의해 뷰가 구동되도록 선호
    let store: StoreOf<CounterAppReducer>
    
    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1.tab1, action: \.tab1))
                .tabItem {
                    Text("1")
                }
            
            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Text("2")
                }
        }
    }
}

#Preview {
    CounterMainTabView(store: Store(initialState: CounterAppReducer.State()) {
        CounterAppReducer()
    })
}
