//
//  FrameworkDetailView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/11/24.
//

import SwiftUI

struct FrameworkListDetailView: View {
    
    let framework: Framework
    @State private var isShowingSafariView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            FrameworkTitleView(framework: framework)
            
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Button {
                isShowingSafariView = true
            } label: {
               AFButton(title: "Learn More")
            }

        }
        .sheet(isPresented: $isShowingSafariView) {
            SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
        }
    }
}
