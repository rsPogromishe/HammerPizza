//
//  MainMenuAssemble.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 17.10.2022.
//

import UIKit

class MainMenuAssemble {
    static func assembleMainMenu() -> UIViewController {
        let view = MainMenuViewController()
        let presenter = MainMenuPresenter()

        presenter.view = view
        view.presenter = presenter

        return view
    }
}
