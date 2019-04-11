//
//  Network.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/9/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

class Network {
    static let shared = Network()
    
    func fetchAppSearchData(searchTerm: String, completion: @escaping (Result<SearchResults, Error>) -> ()) {
        let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchJSON(urlString: urlString, completion: completion)
    }
    
    func fetchNewAppsWeLove(completion: @escaping (Result<AppGroup, Error>) -> () ) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (Result<AppGroup, Error>) -> () ) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (Result<AppGroup, Error>) -> () ) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (Result<AppGroup, Error>) -> ()) {
        fetchJSON(urlString: urlString, completion: completion)
    }
    
    func fetchHeaderData(completion: @escaping (Result<[AppHeader], Error>) -> () ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchJSON(urlString: urlString, completion: completion)
    }
    
    func fetchJSON<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> () ) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch header data", error.localizedDescription)
            }
            
            guard let data = data else { return }
            print("Header Data", data)
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                print("Failed to decode header data", error.localizedDescription)
            }
        }.resume()
    }
}
