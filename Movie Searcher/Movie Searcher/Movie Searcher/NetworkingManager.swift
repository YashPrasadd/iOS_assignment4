//
//  NetworkingManager.swift
//  Movie Searcher
//
//  Created by user235625 on 12/14/23.
//

import Foundation

class NetworkingManager {
    
    static var shared = NetworkingManager()
    
    func searchForMovies(searchTerm: String, completionHandler: @escaping (_ data: MovieResult?) -> Void) {
        guard let urlObj = URL(string: "https://www.omdbapi.com/?apikey=5bcc3d61&s=\(searchTerm)&type=movie") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let goodData = data {
                do {
                    let result = try JSONDecoder().decode(MovieResult.self, from: goodData)
                    DispatchQueue.main.async {
                        completionHandler(result)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
}
