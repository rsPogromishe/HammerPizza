//
//  MainMenuPresenter.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 17.10.2022.
//

import UIKit

class MainMenuPresenter {
    weak var view: MainMenuViewInput?

    var currentCity: String = "Москва"
    var adsArray: [UIImage] = [
        UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!,
        UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!
    ]
    var menuItems: [MenuItem] = []
    var menuItemsCache: [MenuItem] = []
    var categories: [String] = MealType.allCases.map { $0.rawValue }

    func viewDidLoad() {
        restoreData()
        fetchAllMenuItems()
    }

    private func restoreData() {
        guard let fileURL = getFileURL() else {
            return
        }
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedMenuItemsData = try? Data(contentsOf: fileURL),
           let decodedMenuItems = try?
            propertyListDecoder.decode(Array<MenuItem>.self, from: retrievedMenuItemsData) {
            self.menuItemsCache = decodedMenuItems
        }
    }

    func saveMenuCache() {
        guard let fileURL = getFileURL() else {
            return
        }
        for item in self.menuItems {
            guard let newItem = item.copy() as? MenuItem else {
                return
            }
            self.menuItemsCache.append(newItem)
        }
        let propertyListEncoder = PropertyListEncoder()
        let encodedMenuItems = try? propertyListEncoder.encode(self.menuItemsCache)
        try? encodedMenuItems?.write(to: fileURL, options: .noFileProtection)
    }

    private func getFileURL() -> URL? {
        let documentsUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let fileUrl = documentsUrl?.appendingPathComponent("menuItems").appendingPathExtension("plist")
        return fileUrl
    }

    private func fetchAllMenuItems() {
        self.menuItems = []
        let globalSerialQueue = DispatchQueue(label: "GlobalSerialQueue")
        let group = DispatchGroup()
        globalSerialQueue.async {
            for category in MealType.allCases {
                group.enter()
                NetworkManager().fetchMenu(
                    category: category.rawValue
                ) { [weak self] response in
                    guard let self = self else { return }
                    let dataToShow = response.results
                    dataToShow.forEach {
                        $0.mealType = MealType(rawValue: category.rawValue)
                    }
                    self.menuItems.append(contentsOf: dataToShow)
                    if category == MealType.allCases[0] {
                        DispatchQueue.main.async {
                            self.view?.reloadTableView()
                        }
                    }
                    group.leave()
                } onError: { error in
                    print(error)
                }
                group.wait()
            }
            DispatchQueue.main.async {
                self.view?.reloadTableViewWithBool(shown: true)
            }
        }
    }
}
