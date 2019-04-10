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
    
    func fetchApp( completion: @escaping ([Result]) -> () ) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch data from url", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let searchResults = try decoder.decode(SearchResult.self, from: data)
                completion(searchResults.results)
            } catch {
                print("Failed to decode Data", error.localizedDescription)
            }
        }.resume()
    }
}
