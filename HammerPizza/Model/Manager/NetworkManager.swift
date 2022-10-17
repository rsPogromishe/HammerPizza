//
//  NetworkManager.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import Foundation

enum NetworkError {
    case failedURL
    case parsingError
    case emptyData
}

class NetworkManager {
    func fetchMenu(
        category: String,
        onCompletion: @escaping ((Menu) -> Void),
        onError: @escaping ((NetworkError) -> Void)
    ) {
        guard let url = createURLcomponents(category: category) else {
            onError(.failedURL)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    if let menu = try self.parseJSON(withData: data) {
                        onCompletion(menu)
                    }
                } catch {
                    onError(.parsingError)
                }
            } else {
                onError(.emptyData)
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

    private func parseJSON(withData data: Data) throws -> Menu? {
        let decoder = JSONDecoder()
        let menuData = try decoder.decode(Menu.self, from: data)
        return menuData
    }
}
