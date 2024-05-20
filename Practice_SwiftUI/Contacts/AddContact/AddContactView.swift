//
//  AddContactView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/20/24.
//

//import SwiftUI
//import ComposableArchitecture
//
//struct AddContactView: View {
//    
//    /*
//     @Bindable var store: 이 속성 래퍼를 사용하여 store를 바인딩 가능하게 만듭니다.
//     이를 통해 SwiftUI 뷰에서 상태를 직접 바인딩하고 관찰할 수 있습니다.
//     */
//    @Bindable // iOS17+
//    var store: StoreOf<AddContactReducer>
//    
//    var body: some View {
//        VStack {
//            /*
//             sending(\.setName)는 Composable Architecture에서 제공하는 기능으로, 뷰의 바인딩을 리듀서의 액션과 연결해줍니다.
//             여기서 \는 키 경로를 나타내며, setName은 리듀서에서 정의한 액션입니다.
//             
//             텍스트 필드를 store.contact.name에 바인딩합니다.
//             텍스트 필드의 값이 변경될 때마다 name 값을 들고 -> setName 액션이 트리거되고, 해당 값이 리듀서에 전달됩니다.
//             */
//            TextField("Name", text: $store.contact.name.sending(\.setName))
//            Button("Save") {
//                store.send(.saveButtonTapped)
//            }
//        } // VStack
//        .toolbar {
//            ToolbarItem {
//                Button("Cancel") {
//                    store.send(.cancelButtonTapped)
//                }
//            }
//        } // toolbar
//        
//    }
//}
//
//#Preview {
//    AddContactView(
//        store: Store(
//            initialState: AddContactReducer.State(
//                contact: Contact(name: "")
//            )
//        ) {
//            AddContactReducer()
//        }
//    )
//}

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    
    @Bindable var store: StoreOf<AddContactReducer>
    
    var body: some View {
        NavigationStack {
            TextField("이름을 입력하세요.", text: $store.contact.name.sending(\.setName))
            Button("저장하기") {
                store.send(.saveButtonTapped)
            }
            .toolbar {
                ToolbarItem {
                    Button("취소") {
                        store.send(.cancelButtonTapped)
                    }
                }
            }
        } // VStack
      
    }
}
