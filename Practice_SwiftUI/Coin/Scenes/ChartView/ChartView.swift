//
//  ChartView.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import SwiftUI

struct ChartView: View {
    
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Button("소켓 종료") {
                    WebSocketManager.shared.closeWebSocket()
                }
                ForEach(viewModel.output.askOrderBook) { item in
                    Text(item.price.formatted())
                        .padding(.all, 1)
                        .background(.lightBlue)
                }
                
                ForEach(viewModel.output.bidOrderBook) { item in
                    Text(item.price.formatted())
                        .padding(.all, 1)
                        .background(Color.red.opacity(0.2))
                }
            } // VStack
            .frame(maxWidth: .infinity)
        } // ScrollView
        .onAppear {
            viewModel.action(.onApear)
        }
    }
}

#Preview {
    ChartView()
}
