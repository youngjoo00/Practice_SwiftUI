//
//  FrameworkGridView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/11/24.
//

import SwiftUI

struct FrameworkListView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(MockData.frameworks) { item in
//                    NavigationLink {
//                        FrameworkListDetailView(framework: item,
//                                            isShowingDetailView: $viewModel.isShowingDetailView)
//                    } label: {
//                        FrameworkListTitleView(framework: item)
//                    }
//                    
                    NavigationLink(value: item) {
                        FrameworkListTitleView(framework: item)
                    }
                }
            }
            .navigationTitle("Apple Frameworks")
            // 데이터타입으로 네비게이션 방식을 사용하면서 데이터타입을 중요시하게 됨
            .navigationDestination(for: Framework.self) { item in
                FrameworkListDetailView(framework: item)
            }
        } // NavigationView
        .tint(Color(.label))
       
    }
}

#Preview {
    FrameworkListView()
}
