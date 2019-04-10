//
//  SearchResult.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/9/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let trackName: String?
    let primaryGenreName: String?
    let averageUserRating: Double?
    let screenshotUrls: [String]?
    let artworkUrl100: String?
}
