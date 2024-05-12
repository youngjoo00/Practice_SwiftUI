//
//  ChartViewModel.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import Combine
import SwiftUI

final class ChartViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
    
    deinit {
        WebSocketManager.shared.closeWebSocket()
    }
}

extension ChartViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    enum Action {
        case onApear
    }
    
    func action(_ action: Action) {
        switch action {
        case .onApear:
            input.onAppear.send(())
        }
    }
    
    struct Output {
        var askOrderBook: [OrderBookItem] = []
        var bidOrderBook: [OrderBookItem] = []
    }
    
    func transform() {
        input.onAppear
            .sink { _ in
                WebSocketManager.shared.openWebSocket()
                
                WebSocketManager.shared.send(
                    """
                        [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
                    """
                )
            }
            .store(in: &cancellables)
        
        WebSocketManager.shared.orderBookSubject
            .sink { [weak self] order in
                guard let self else { return }
                output.askOrderBook = order.orderbook_units
                    .map {
                        .init(price: $0.ask_price, size: $0.ask_size)
                    }
                
                output.bidOrderBook = order.orderbook_units
                    .map {
                        .init(price: $0.bid_price, size: $0.bid_size)
                    }
            }
            .store(in: &cancellables)
    }
}
