//
//  NetworkManager.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import Foundation

enum NetworkError: Error {
    case failedURL
    case parsingError
    case emptyData
}

class NetworkManager {
    func fetchResponse<T: Decodable>(
        category: String,
        onCompletion: @escaping ((Result<T, NetworkError>) -> Void)
    ) {
        guard let url = createURLcomponents(category: category) else {
            onCompletion(.failure(.failedURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                onCompletion(.failure(.emptyData))
                return
            }
            do {
                let reponse = try JSONDecoder().decode(T.self, from: data)
                onCompletion(.success(reponse))
            } catch {
                onCompletion(.failure(.parsingError))
            }
        }.resume()
    }

    private func createURLcomponents(category: String) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.spoonacular.com"
        urlComponents.path = "/recipes/complexSearch"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: category),
            URLQueryItem(name: "apiKey", value: "9df481a31a6a445ea9db910a919141b7")
        ]

        return urlComponents.url
    }
}
