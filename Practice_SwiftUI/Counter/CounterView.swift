//
//  CounterView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/19/24.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            Text("\(store.count)")
            
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .padding()
            .background(Color.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Button(store.isTimerRunning ? "Stop" : "Start") {
                store.send(.timerButtonTapped)
            }
            .padding()
            .background(Color.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
