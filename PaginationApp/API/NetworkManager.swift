//
//  NetworkManager.swift
//  PaginationApp
//
//  Created by Kamal Kumar on 29/05/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    private var currentPage = 1
    private let limit = 10
    
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        let urlString = "\(baseURL)?_page=\(currentPage)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts, nil)
                self.currentPage += 1
            } catch let decodeError {
                completion(nil, decodeError)
            }
        }.resume()
    }
}

