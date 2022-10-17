//
//  MainMenuViewInput.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 17.10.2022.
//

import Foundation

protocol MainMenuViewInput: AnyObject {
    func reloadTableView()
    func reloadTableViewWithBool(shown: Bool)
}
