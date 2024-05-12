//
//  Market.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import Foundation

typealias Markets = [Market]

struct Market: Hashable, Decodable, Identifiable {
    let id = UUID()
    let market, koreanName, englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.market = try container.decode(String.self, forKey: .market)
        self.koreanName = try container.decode(String.self, forKey: .koreanName)
        self.englishName = try container.decode(String.self, forKey: .englishName)
    }
}
