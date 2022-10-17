//
//  CategoryCollectionViewCell.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryLabel)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor),
            categoryLabel.rightAnchor.constraint(equalTo: rightAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with category: MealType) {
        categoryLabel.text = category.rawValue
    }

    func makeTitleBold() {
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        categoryLabel.textColor = .red
    }

    func makeTitleStandart() {
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.textColor = UIColor.red.withAlphaComponent(0.5)
    }
}
