//
//  MenuItemTableViewCell.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    static let identifier = "MenuItemTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let minimumPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        minimumPriceButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addSubview(itemImageView)
        addSubview(descriptionLabel)
        addSubview(minimumPriceButton)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            itemImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            itemImageView.widthAnchor.constraint(equalToConstant: 132),

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 32),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 1),

            minimumPriceButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            minimumPriceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            minimumPriceButton.widthAnchor.constraint(equalToConstant: 87),
            minimumPriceButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with item: MenuItem) {
        nameLabel.text = item.title
        descriptionLabel.text = item.title
        minimumPriceButton.setTitle(item.title, for: .normal)

        DispatchQueue.global().async {
            guard let imageURL = URL(string: item.image) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.itemImageView.image = UIImage(data: imageData)
            }
        }
    }
}
