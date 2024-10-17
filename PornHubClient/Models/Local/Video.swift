//
//  Video.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import Foundation

struct Video {
    let success: Bool
    let details: VideoDetails?
    let source: URL?
    let assets: [String]
}

extension Video {
    init(from serverModel: ServerVideoModel) {
        self.success = serverModel.success ?? false
        self.details = serverModel.data.map(VideoDetails.init)
        self.source = URL(string: serverModel.source ?? "")
        self.assets = serverModel.assets ?? []
    }
}
