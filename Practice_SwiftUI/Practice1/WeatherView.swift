//
//  ContentView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/10/24.
//

import SwiftUI

struct WeatherView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
            VStack {
                CityTextView(cityName: "서울특별시")
                
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                      temperature: 20)
                
                HStack(spacing: 20) {
                    HorizontalWeatherView(dayOfWeek: "TUE",
                                          imageName: "cloud.sun.fill",
                                          temperature: 20)
                    
                    HorizontalWeatherView(dayOfWeek: "WED",
                                          imageName: "sun.max.fill",
                                          temperature: 20)
                    
                    HorizontalWeatherView(dayOfWeek: "THU",
                                          imageName: "wind.snow",
                                          temperature: 20)
                    
                    HorizontalWeatherView(dayOfWeek: "FRI",
                                          imageName: "sunset.fill",
                                          temperature: 20)
                    
                    HorizontalWeatherView(dayOfWeek: "SAT",
                                          imageName: "snow",
                                          temperature: -10)
                } // HStack
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  background: .white)
                }
                
                Spacer()
            } // VStack
            
            
        } // ZStack
        .onAppear {
            let button = WeatherButton(title: "Change Day Time",
                                       textColor: .blue,
                                       background: .white)
            
            print(type(of: button.body))
        }
    }
}

#Preview {
    WeatherView()
}

struct HorizontalWeatherView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.title3)
                .foregroundStyle(.white)
            
            Image(systemName: imageName)
//                .renderingMode(.original)
                .symbolRenderingMode(.multicolor) // 심볼 전용 렌더링모드가 있네
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
        } // VStack
    }
}

struct BackgroundView: View {
    
    // 바인딩의 목적은 State 로 연결되어 있는 값을 변경하기 위해 사용하는 것이지
    // 단순히 읽는 것이 목적이라면 필요없다!!
//    @Binding var isNight: Bool
    var isNight: Bool
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue,
//                                                   isNight ? .gray : .lightBlue]),
//                       startPoint: .topLeading,
//                       endPoint: .bottomTrailing)
//        .ignoresSafeArea()
        
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit) // 공간안에 fit 하게 들어감
                .frame(width: 180, height: 180, alignment: .center)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
    }
}
