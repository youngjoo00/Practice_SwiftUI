//
//  ContactsReducer.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

//import ComposableArchitecture
//
//@Reducer
//struct ContactsReducer {
//    
//    // @ObservableState를 사용하면 State 구조체가 SwiftUI 뷰에 바인딩될 때 자동으로 관찰 가능한 상태로 변환됩니다.
//    @ObservableState
//    struct State {
//        var contacts: IdentifiedArrayOf<Contact> = []
//        @Presents var addContact: AddContactReducer.State?
//    }
//    
//    enum Action {
//        case addButtonTapped
//        case addContact(PresentationAction<AddContactReducer.Action>) // AddContactReducer.Action 에서 발생하는 모든 액션 감지
//    }
//    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .addButtonTapped:
//                state.addContact = AddContactReducer.State(contact: Contact(name: ""))
//                return .none
//                
//            case let .addContact(.presented(.delegate(.saveContact(contact)))):
//                state.contacts.append(contact)
//                return .none
//                
//            case .addContact:
//                return .none
//            }
//        }
//        // $ -> Binding
//        // nil 이 아닐 때 state 상태를 가져옴
//        .ifLet(\.$addContact, action: \.addContact) {
//            AddContactReducer() // 액션과 상태는 이쪽 리듀서 사용
//        }
//    }
//}

import ComposableArchitecture

@Reducer
struct ContactsReducer {
    
    @ObservableState
    struct State {
        var contacts: IdentifiedArrayOf<Contact> = []
        @Presents var addContact: AddContactReducer.State?
    }
    
    enum Action {
        case pulsButtonTapped
        case addContact(PresentationAction<AddContactReducer.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .pulsButtonTapped:
                state.addContact = AddContactReducer.State(contact: Contact(name: ""))
                return .none
                
            case .addContact(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact else {
                    return .none
                }
                
                state.contacts.append(contact)
                state.addContact = nil
                return .none
                
            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none
                
            case .addContact:
                return .none
            }
        }
        // 여기서는 왜 $ 를 쓰는걸까요..
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactReducer()
        }
    }
}
