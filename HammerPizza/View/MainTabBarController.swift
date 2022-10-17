//
//  MainTabBarController.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 17.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let menuImage = UIImage(named: "menuIcon") else { return }
        guard let contactsImage = UIImage(named: "contactsIcon") else { return }
        guard let profileImage = UIImage(named: "accountIcon") else { return }
        guard let orderImage = UIImage(named: "basketIcon") else { return }

        viewControllers = [
            generateViewController(
                rootViewController: MainMenuAssemble.assembleMainMenu(),
                image: menuImage,
                title: "Меню"
            ),
            generateViewController(rootViewController: UIViewController(), image: contactsImage, title: "Контакты"),
            generateViewController(rootViewController: UIViewController(), image: profileImage, title: "Профиль"),
            generateViewController(rootViewController: UIViewController(), image: orderImage, title: "Корзина")
        ]

        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .white
        tabBar.tintColor = .red
        view.backgroundColor = .white
    }

    private func generateViewController(
        rootViewController: UIViewController,
        image: UIImage,
        title: String
    ) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
}
