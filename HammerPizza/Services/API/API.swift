//
//  API.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 04.04.2023.
//

import Foundation

enum API {
    static private let manager = NetworkManager()
}

extension API {
    static func fetchMenu(category: String, completion: @escaping (Menu) -> Void) {
        manager.fetchResponse(category: category) { (result: Result<Menu, NetworkError>) in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
