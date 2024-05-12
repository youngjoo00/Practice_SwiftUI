//
//  NetworkManager.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let baseURL = "https://api.upbit.com/v1/market/all"
    
    func callAPI() async throws -> Markets {
        let url = URL(string: baseURL)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidRespons
        }
        
        do {
            let decodedData = try JSONDecoder().decode(Markets.self, from: data)
            return decodedData
        } catch {
            throw APIError.failDecoding
        }
    }
}
