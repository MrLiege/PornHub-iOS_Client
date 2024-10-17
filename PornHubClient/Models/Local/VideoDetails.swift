//
//  VideoDetails.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation

struct VideoDetails {
    let title: String?
    let id: String?
    let image: String?
    let duration: String?
    let views: String?
    let rating: String?
    let uploaded: String?
    let upvotes: Int?
    let downvotes: Int?
    let models: [String]?
    let tags: [String]?
}

extension VideoDetails {
    init(from serverModel: ServerVideoDetailsModel) {
        self.title = serverModel.title
        self.id = serverModel.id
        self.image = serverModel.image
        self.duration = serverModel.duration
        self.views = serverModel.views
        self.rating = serverModel.rating
        self.uploaded = serverModel.uploaded
        self.upvotes = Int(serverModel.upvoted) ?? 0
        self.downvotes = Int(serverModel.downvoted) ?? 0
        self.models = serverModel.models
        self.tags = serverModel.tags
    }
}
