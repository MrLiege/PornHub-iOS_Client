//
//  PornHubEndpoint.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation
import Moya

enum PornHubEndpoint: TargetType {
    case byId(id: String)
    case random
    case search(key: String, page: Int?, sort: String?)
    
    var baseURL: URL {
        guard let url = URL(string: "https://lust.scathach.id/pornhub/") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .byId:
            return "get"
        case .random:
            return "random"
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .byId(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case .random:
            return .requestPlain
        case .search(key: let key, page: let page, sort: let sort):
            var parameters: [String: Any] = ["key" : key]
            if let page = page {
                parameters["page"] = page
            }
            if let sort = sort {
                parameters["sort"] = sort
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? { nil }
}
