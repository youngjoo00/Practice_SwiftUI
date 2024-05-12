//
//  WebSocketManager.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    
    static let shared = WebSocketManager()
    private override init() {}
    
    // MARK: - 1. Property
    private var websocket: URLSessionWebSocketTask?
    private var isOpen = false
    private var timer: Timer?
    var orderBookSubject = PassthroughSubject<OrderBook, Never>()
    
    // 2. setting open/close
    func openWebSocket() {
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            URLSession.shared.dataTask(with: url).resume() // 여길 왜하는거지?
            
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            websocket = session.webSocketTask(with: url)
            websocket?.resume()
            
            ping()
        }
    }
    
    func closeWebSocket() {
        websocket?.cancel(with: .goingAway, reason: nil)
        websocket = nil
        
        timer?.invalidate()
        timer = nil
        
        isOpen = false
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    // 소켓 통신 Open
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Socket Open")
        
        isOpen = true
        // 소켓 통로가 오픈 된 이후 -> 쏟아져나오는 서버의 응답값을 받음
        receiveSocketData()
    }
    
    // 소켓 통신 Close
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Socket Close")
        
        isOpen = false
    }
}

extension WebSocketManager {
    
    // 얘는 뭐지?
    func send(_ string: String) {
        websocket?.send(.string(string)) { error in
            print(error)
        }
    }
    
    private func receiveSocketData() {
        if isOpen {
            websocket?.receive { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    switch success {
                    case .data(let data):
                        // 통신 -> 디코딩 -> 서브젝트로 방출
                        if let decodedData = try? JSONDecoder().decode(OrderBook.self, from: data) {
                            self.orderBookSubject.send(decodedData)
                        }
                    case .string(let string): print(string)
                    @unknown default: print("ok")
                    }
                case .failure(let failure):
                    print(failure)
                }
                self.receiveSocketData()
            }
        }
    }
    
    private func ping() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
            self?.websocket?.sendPing { error in
                if let error {
                    print("ping Error: ", error.localizedDescription)
                } else {
                    print("good")
                }
            }
        }
    }
    
}
