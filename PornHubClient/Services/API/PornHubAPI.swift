//
//  PornHubAPI.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class PornHubAPI {
    let provider: MoyaProvider<PornHubEndpoint>
    
    init() {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let logger = NetworkLoggerPlugin(configuration: loggerConfig)
        self.provider = MoyaProvider<PornHubEndpoint>(plugins: [logger])
    }
}

extension PornHubAPI {
    func getVideo(byId: String) -> AnyPublisher<Video, MoyaError> {
        provider.requestPublisher(.byId(id: byId))
            .filterSuccessfulStatusCodes()
            .map(ServerVideoModel.self)
            .map { serverModel in
                Video(from: serverModel)
            }
            .mapError({ error in
                print(error.localizedDescription)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getRandomVideo() -> AnyPublisher<Video, MoyaError> {
        provider.requestPublisher(.random)
            .filterSuccessfulStatusCodes()
            .map(ServerVideoModel.self)
            .map { serverModel in
                Video(from: serverModel)
            }
            .mapError({ error in
                print(error.localizedDescription)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func searchVideos(key: String, page: Int = 1, sort: String = "mr") -> AnyPublisher<[Video], MoyaError> {
        provider.requestPublisher(.search(key: key, page: page, sort: sort))
            .filterSuccessfulStatusCodes()
            .map([ServerVideoModel].self)
            .map { serverModels in
                serverModels.map { Video(from: $0) }
            }
            .mapError({ error in
                print(error.localizedDescription)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
