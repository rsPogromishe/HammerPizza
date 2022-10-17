//
//  ViewController.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    var presenter: MainMenuPresenter!

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    var allCategoriesShown = false {
        didSet {
            tableView.reloadData()
            presenter.menuItemsCache = []
            presenter.saveMenuCache()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemGroupedBackground

        presenter.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let title = UIBarButtonItem(
            title: presenter.currentCity,
            style: .plain,
            target: self,
            action: nil
        )
        let arrow = UIBarButtonItem(
            image: UIImage(systemName: "chevron.down"),
            style: .done,
            target: self,
            action: nil
        )
        arrow.imageInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0)
        navigationItem.leftBarButtonItems = [ title, arrow ]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .systemGroupedBackground
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .systemGroupedBackground
    }

    private func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            let numberOfRows = self.allCategoriesShown ? presenter.menuItems.count : presenter.menuItemsCache.count
            return numberOfRows
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let subviewsArray = tableView.subviews
        let categoryView = subviewsArray.first {
            $0.tag == 1001
        }
        guard let castedCategoryView = categoryView as? CategoriesView else { return }

        guard let arrayOfIndices: [Int] = tableView.indexPathsForVisibleRows?.filter({
            $0.section == 1
        }).map({
            $0.row
        }) else { return }
        var arrayOfMenuItems: [MenuItem] = []
        for menuItemNumber in arrayOfIndices {
            let dataArray = self.allCategoriesShown ? presenter.menuItems : presenter.menuItemsCache
            arrayOfMenuItems.append(dataArray[menuItemNumber])
        }
        let mappedArrayOfMenuItems = arrayOfMenuItems.map { ($0.mealType, 1) }
        let counts = Dictionary(mappedArrayOfMenuItems, uniquingKeysWith: +)
        var mostUsed: MealType = .pizza
        if let (category, _) = counts.max(by: { $0.1 < $1.1 }) {
            mostUsed = category ?? .pizza
        }

        castedCategoryView.categoryChanged(with: MealType.allCases.firstIndex(where: {
            $0 == mostUsed
        })!)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return .none
        }
        let view = CategoriesView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: tableView.bounds.width,
                height: 70
            ),
            categories: presenter.categories
        )
        view.delegate = self
        view.tag = 1001
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: CollectionTableViewCell.identifier,
                for: indexPath
            ) as? CollectionTableViewCell {
                cell.configure(with: presenter.adsArray)
                return cell
            }
            return UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MenuItemTableViewCell.identifier,
                for: indexPath
            ) as? MenuItemTableViewCell else { return UITableViewCell() }
            if self.allCategoriesShown {
                cell.configure(with: presenter.menuItems[indexPath.row])
            } else {
                cell.configure(with: presenter.menuItemsCache[indexPath.row])
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130
        case 1:
            return 240
        default:
            return 200
        }
    }
}

extension MainMenuViewController: FooterViewTapDelegate {
    func moveTo(category: String) {
        let array = self.allCategoriesShown ? presenter.menuItems : presenter.menuItemsCache
        guard let firstCategoryItem = array.firstIndex(where: { $0.mealType?.rawValue == category }) else { return }
        self.tableView.scrollToRow(at: IndexPath(row: firstCategoryItem, section: 1), at: .top, animated: true)
    }
}

extension MainMenuViewController: MainMenuViewInput {
    func reloadTableView() {
        tableView.reloadData()
    }

    func reloadTableViewWithBool(shown: Bool) {
        tableView.reloadData()
        allCategoriesShown = true
    }
}
