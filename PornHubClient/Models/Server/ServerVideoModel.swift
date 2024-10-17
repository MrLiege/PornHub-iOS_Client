//
//  ServerVideoModel.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation

struct ServerVideoModel: Decodable {
    let success: Bool?
    let data: ServerVideoDetailsModel?
    let source: String?
    let assets: [String]?
}

struct ServerVideoDetailsModel: Decodable {
    let title: String
    let id: String
    let image: String
    let duration: String
    let views: String
    let rating: String
    let uploaded: String
    let upvoted: String
    let downvoted: String
    let models: [String]
    let tags: [String]
}
