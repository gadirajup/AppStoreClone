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
    
    func fetchAppSearchData(searchTerm: String, completion: @escaping (Result<[SearchResult], Error>) -> ()) {
        let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch data from url", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }

            let decoder = JSONDecoder()

            do {
                let searchResults = try decoder.decode(SearchResults.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(searchResults.results))
                }

            } catch {
                print("Failed to decode Data", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
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
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching top apps", error.localizedDescription)
                completion(.failure(error))
            }
            
            guard let data = data else {return}
            
            print(data)
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(.success(appGroup))
            } catch {
                print("Failed to decode app group", error.localizedDescription)
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchHeaderData(completion: @escaping (Result<[AppHeader], Error>) -> () ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch header data", error.localizedDescription)
            }
            
            guard let data = data else { return }
            print("Header Data", data)
            do {
                let results = try JSONDecoder().decode([AppHeader].self, from: data)
                completion(.success(results))
            } catch {
                print("Failed to decode header data", error.localizedDescription)
            }
        }.resume()
    }
}
