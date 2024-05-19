//
//  NumberFactClient.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/19/24.
//

import Foundation
import ComposableArchitecture

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed
    case timeout
}

// 클라이언트, client: 네트워크로 연결된 서버로부터 정보를 제공받는 컴퓨터
struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    
    static let liveValue = Self { number in
    
        guard let url = URL(string: "http://numbersapi.com/\(number)") else {
            throw NetworkError.invalidURL
        }
    
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: configuration)
        
        do {
            let (data, response) = try await session.data(from: url)
            let decodedData = String(decoding: data, as: UTF8.self)
            return decodedData
        } catch let urlError as URLError where urlError.code == .timedOut {
            throw NetworkError.timeout
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }

}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
