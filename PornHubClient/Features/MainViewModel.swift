//
//  MainViewModel.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation
import Combine
import CombineExt

final class MainViewModel: ObservableObject {
    let input: Input
    @Published var output: Output
    
    private let api: PornHubAPI
    private var cancellables = Set<AnyCancellable>()
    
    init(api: PornHubAPI = PornHubAPI()) {
        self.api = api
        self.input = Input()
        self.output = Output()
        bind()
    }
}

extension MainViewModel {
    func bind() {
        bindRandom()
    }
    
    func bindRandom() {
        print("Запрос")
        let request = input.onAppear
            .first()
            .map { [unowned self] in
                self.api.getRandomVideo()
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        request
            .failures()
            .sink { error in
                print(error)
            }
            .store(in: &cancellables)
        
        request
            .values()
            .sink { [weak self] value in
                self?.output.model = value
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var model: Video? = nil
        var error: String? = nil
    }
}

