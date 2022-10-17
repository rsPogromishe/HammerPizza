//
//  Model.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import Foundation

struct Menu: Codable {
    var results: [MenuItem]
}

enum MealType: String, CaseIterable, Codable {
    case pizza = "Pizza"
    case pasta = "Pasta"
    case dessert = "Dessert"
    case drinks = "Drinks"

    init(rawValue: String) {
        switch rawValue {
        case "Pizza"  : self = .pizza
        case "Pasta"  : self = .pasta
        case "Dessert": self = .dessert
        case "Drinks": self = .drinks
        default: self = .pizza
        }
    }
}

class MenuItem: Codable, NSCopying {
    var title: String
    var image: String
    var mealType: MealType?

    init(title: String, image: String, mealType: MealType) {
        self.title = title
        self.image = image
        self.mealType = mealType
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = MenuItem(title: title, image: image, mealType: mealType ?? .pizza)
        return copy
    }
}
