//
//  CounterFeature.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/19/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterReducer {
    
    @ObservableState
    struct State {
        var count = 0
        var isLoading = false
        var fact: String?
        var isTimerRunning = false
        var errorMessage: String?
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(Result<String, NetworkError>)
        case timerButtonTapped
        case timerTick
    }
    
    enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                state.errorMessage = nil
                return .none
                
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                state.errorMessage = nil
                return .none
                
            case .factButtonTapped:
                // 여기는 동기
                state.fact = nil
                state.errorMessage = nil
                state.isLoading = true
            
                /*
                 클로저 캡처 [count = state.count] 이해하기
                 
                 클로저 캡처 리스트 [count = state.count]는 클로저가 실행될 때 state.count의 현재 값을 count라는 새로운 상수에 복사하여 사용하겠다는 것을 의미합니다.
                 이는 클로저 내부에서 사용되는 state.count 값이 클로저가 생성될 때의 값으로 고정되어야 할 때 유용합니다.
                 특히 비동기 작업에서는 작업이 시작될 때의 상태 값을 '스냅샷'하여 사용해야 할 때가 많은데, 이 때 캡처 리스트를 사용합니다.
                 
                 클로저 캡처 리스트를 사용하는 주된 이유는 다음과 같습니다:
                 값 캡처: 클로저가 실행될 때 외부 변수의 현재 값을 캡처하여, 클로저 내부에서 사용합니다. 이는 비동기 작업과 같이 클로저 실행이 지연될 때 유용합니다.
                 참조 사이클 방지: 클로저가 클래스 인스턴스의 프로퍼티나 메소드를 캡처할 때 참조 사이클을 방지하기 위해 사용될 수 있습니다.
                 이 예시에서는 클로저가 실행되는 시점에 state.count의 값을 count에 복사하여 사용함으로써, 비동기 작업이 실행되는 동안 state.count 값이 변경되더라도, 해당 비동기 작업에는 영향을 주지 않는 '스냅샷' 값을 사용하게 됩니다.
                 */
                return .run { [count = state.count] send in
                    // 클로저는 애초에 비동기로 작동해서 여기서 사용이 가능한거였음
//                    let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)")!)
//                    let fact = String(decoding: data, as: UTF8.self)
//                    await send(.factResponse(fact)) // send 는 반드시 await 키워드를 붙여서 액션 로직이 마치면 다시 여기로 돌아오게끔 해야함
                    
//                    리팩토링 1
//                    let response = try await numberFact.fetch(count)
//                    await send(.factResponse(response))
                    
//                    리팩토링 2
//                    try await send(.factResponse(numberFact.fetch(count)))
                    do {
                        let fact = try await numberFact.fetch(count)
                        await send(.factResponse(.success(fact)))
                    } catch {
                        if let networkError = error as? NetworkError {
                            await send(.factResponse(.failure(networkError)))
                        } else {
                            await send(.factResponse(.failure(.requestFailed(error))))
                        }
                    }
                }
                
            // result Type 은 내가 선택해서 성공/실패 케이스로 따로 받을 수 있네??
            case let .factResponse(.success(fact)):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case let .factResponse(.failure(networkError)):
                state.isLoading = false
                switch networkError {
                case .timeout:
                    state.errorMessage = "The request timed out"
                default:
                    state.errorMessage = networkError.localizedDescription
                }
                return .none
                
            case .timerButtonTapped:
                state.isTimerRunning.toggle()
                
                if state.isTimerRunning {
                    return .run { send in
                        // while await 구문은 없다네요
                        // for await 을 사용합시다
                        /*
                         1. for await 구문은 비동기 시퀀스에서 요소를 하나씩 순회하면서 대기(awaiting)하는 역할
                         2. self.clock.timer(interval: .seconds(1))는 매 1초마다 이벤트를 생성하는 비동기 시퀀스를 반환
                         */
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                state.errorMessage = nil
                return .none
            }
        }
    }
}
