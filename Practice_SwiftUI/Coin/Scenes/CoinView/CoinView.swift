//
//  CoinView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject var viewmodel = CoinViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewmodel.output.columns) {
                ForEach(viewmodel.output.markets) { item in
                    VStack {
                        Text(item.market)
                        Text(item.koreanName)
                        Text(item.englishName)
                    }
                }
            }
        }
        .task {
            viewmodel.action(.onAppear)
        }
    }
}

#Preview {
    CoinView()
}
