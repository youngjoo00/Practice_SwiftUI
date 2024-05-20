//
//  AddContactReducer.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

//import ComposableArchitecture
//
//@Reducer
//struct AddContactReducer {
//    
//    @ObservableState
//    struct State {
//        var contact: Contact
//    }
//    
//    enum Action {
//        case saveButtonTapped
//        case cancelButtonTapped
//        case setName(String)
//        case delegate(Delegate)
//        
//        // 부모가 감지하지말고, 자식이 액션을 보내게끔 해보자.
//        enum Delegate {
//            case saveContact(Contact)
//        }
//    }
//    
//    @Dependency(\.dismiss)
//    var dismiss
//    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .saveButtonTapped:
//                return .run { [contact = state.contact] send in
//                    await send(.delegate(.saveContact(contact)))
//                    await dismiss()
//                }
//                
//            case .cancelButtonTapped:
//                return .run { _ in await dismiss() }
//                
//            case let .setName(name):
//                state.contact.name = name
//                print(name)
//                return .none
//                
//            case .delegate:
//                return .none
//            }
//        }
//    }
//}

import ComposableArchitecture

@Reducer
struct AddContactReducer {
    
    @ObservableState
    struct State {
        var contact: Contact
    }
    
    // 섹션4 delegate 리팩토링의 이유와 이점이 궁금합니다,,
    enum Action {
        case setName(String)
        case saveButtonTapped
        case cancelButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setName(name):
                state.contact.name = name
                return .none
                
            case .saveButtonTapped:
                return .none
                
            case .cancelButtonTapped:
                return .none
            }
        }
    }
}
