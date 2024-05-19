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
}

// 클라이언트, client: 네트워크로 연결된 서버로부터 정보를 제공받는 컴퓨터
struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = Self { number in
        let (data, response) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    }
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
