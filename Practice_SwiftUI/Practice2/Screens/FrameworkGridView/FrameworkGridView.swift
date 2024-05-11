//
//  FrameworkGridView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/11/24.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    // Identifable 프로토콜을 채택해서 -> UUID 를 통해 어짜피 모든 값이 고유함을 증명한다면,
                    // ForEach 를 사용할때 자동으로 id 프로퍼티를 찾아서 구분짓기에 id 를 명시 할 필요가 없다.
                    ForEach(MockData.frameworks) { framework in
                        FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                // 탭 하면 뷰모델에 값을 넘겼음
                                viewModel.selectedFramework = framework
                            }
                    }
                } // LazyVGrid - 1. 스크롤 기능이 없음
            } // ScrollView - 2. 그래서 스크롤뷰를 붙여서 사용함
            .navigationTitle("Apple Frameworks")
            // isPresented - 무조건 true 면 프레젠트, false 닫음 형태인가봄
//            .sheet(isPresented: $viewModel.isShowingDetailView) {
//                FrameworkDetailView(framework: viewModel.selectedFramework ?? MockData.sampleFramework,
//                                    isShowingDetailView: $viewModel.isShowingDetailView)
//            }
            .fullScreenCover(isPresented: $viewModel.isShowingDetailView) {
                FrameworkDetailView(framework: viewModel.selectedFramework ?? MockData.sampleFramework,
                                    isShowingDetailView: $viewModel.isShowingDetailView)
            }
        } // NavigationView

       
    }
}

#Preview {
    FrameworkGridView()
}
