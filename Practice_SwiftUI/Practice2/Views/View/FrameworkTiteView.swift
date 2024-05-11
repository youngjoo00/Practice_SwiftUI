//
//  FrameworkTiteView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/11/24.
//

import SwiftUI

struct FrameworkTitleView: View {
    
    let framework: Framework
    
    var body: some View {
        VStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
            // 사이즈에 맞게 텍스트를 동적으로 줄이고 늘이기
                .scaledToFit() // 주어진 사이즈에 맞게 꽉 채운다.
                .minimumScaleFactor(0.6) // 텍스트가 길어지는 경우 비율로 줄이기
        }
        .padding()
    }
  
}
