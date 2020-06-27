//
//  APIService.swift
//  PhotosChallenge
//
//  Created by Judith Lindemann on 26.06.20.
//  Copyright © 2020 Judith Lindemann. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}

enum NetworkingError: Error {
    case noData
}

class APIService {
    
    func loadJSON(then handler: @escaping (Result<[Photo], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { throw NetworkingError.noData }
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                handler(.success(photos))
            } catch {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
