//
//  CoinViewModel.swift
//  Practice_SwiftUI
//
//  Created by youngjoo on 5/12/24.
//

import Combine
import SwiftUI

final class CoinViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published var output = Output()
    
    init() {
        transform()
    }
}

extension CoinViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    enum Action {
        case onAppear
    }
    
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            input.onAppear.send(())
        }
    }
    
    struct Output {
        let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
        var markets: Markets = []
    }
    
    func transform() {
        input.onAppear
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.fetchMarkets()
                }
            }
            .store(in: &cancellables)
    }
    
}


// private func
extension CoinViewModel {
    private func fetchMarkets() async {
        do {
            let markets = try await NetworkManager.shared.callAPI()
            output.markets = markets
        } catch {
            print(error.localizedDescription)
            output.markets = []
        }
    }
    
}
