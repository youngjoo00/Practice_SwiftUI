//
//  WeatherButton.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/10/24.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var background: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(background)
            .foregroundStyle(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
