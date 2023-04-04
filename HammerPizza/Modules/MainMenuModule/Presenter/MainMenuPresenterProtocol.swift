//
//  MainMenuPresenterProtocol.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 03.04.2023.
//

import Foundation
import UIKit

protocol MainMenuPresenterProtocol {
    var currentCity: String { get }
    var adsArray: [UIImage] { get }
    var menuItems: [MenuItem] { get set }
    var menuItemsCache: [MenuItem] { get set }
    var categories: [String] { get set }

    func viewDidLoad()
    func saveMenuCache()
}
