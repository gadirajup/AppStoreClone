//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/11/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

struct AppGroup: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Codable {
    let artistName: String
    let name: String
    let artworkUrl100: String
}
