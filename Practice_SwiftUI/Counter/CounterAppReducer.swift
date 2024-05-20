//
//  CounterAppReducer.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterAppReducer {
    
    struct State {
        struct Temp {
            var tab1 = CounterReducer.State()
        }
        
        var tab1 = Temp()
//        var tab1 = CounterReducer.State()
        var tab2 = CounterReducer.State()
    }
    
    enum Action {
        case tab1(CounterReducer.Action)
        case tab2(CounterReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        /*
         state 에서 var 를 사용하는 이유가 뭘까요?
         
         오류 메시지 "Key path value type 'KeyPath<CounterAppReducer.State, CounterReducer.State>' cannot be converted to contextual type 'WritableKeyPath<CounterAppReducer.State, CounterReducer.State>'"는 불변성을 가진 KeyPath를 가변성을 요구하는 컨텍스트에서 사용하려고 시도했을 때 발생합니다.
         ComposableArchitecture에서 Scope를 사용할 때, 상태(state)와 작업(action)에 대한 키 경로(key path)는 수정 가능해야 합니다. 
         즉, WritableKeyPath 타입이어야 합니다. 하지만 여기서 State 구조체 내의 tab1과 tab2 프로퍼티가 let으로 선언되어 있어 불변(immutable)입니다. 이것이 문제의 원인입니다.
         문제를 해결하기 위해서는 tab1과 tab2 프로퍼티를 var로 선언하여 가변(mutable)으로 만들어야 합니다. 
         이렇게 하면 이 프로퍼티들에 대한 WritableKeyPath를 사용할 수 있게 되어, 오류가 해결됩니다.
         */
        
        /*
         KeyPath (\): Swift에서 \는 KeyPath를 나타냅니다. KeyPath는 특정 타입의 프로퍼티에 접근하기 위한 경로를 지정할 때 사용됩니다. 예를 들어, \.temp.tab1는 temp 프로퍼티 내의 tab1 프로퍼티로의 접근 경로를 나타냅니다.
         CasePath (/): Composable Architecture에서 /는 CasePath를 나타냅니다. CasePath는 enum의 특정 case에 접근하기 위한 경로를 지정할 때 사용됩니다. CasePath는 enum의 case를 안전하게 추출하거나 삽입하는 방법을 제공합니다.
        enum 타입 본인을 시작으로 경로가 시작됨 -> 여기서는 ReducerOf<Self> 이니, Action 에서 시작하겠지요?
         
         어 근데 CasePath 방법으로 쓰면 AnyCasePath 라면서 deprecated 됐네
         
         그냥 KeyPath 로 씁시다..
         */
        
        // 아 스코프의 존재 의의를 알았다.
        // 이 스코프가 state 와 action 을 가리키고 있어서 View 에서 store 로 액션을 보내면 이 스코프에서 처리하는 거였음
        // 실제로 스코프를 주석처리하면 아무일도 일어나지 않음
        Scope(state: \.tab1.tab1, action: \.tab1) {
            CounterReducer() // 이 리듀서를 사용하고, 상태와 액션도 연결한것으로 사용함
        }
        
        Scope(state: \.tab2, action: \.tab2) {
            CounterReducer()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
