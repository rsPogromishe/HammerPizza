//
//  CollectionCell.swift
//  HammerPizza
//
//  Created by Снытин Ростислав on 16.10.2022.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    static let identifier = "AdsCollectionViewCell"

    private let adImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        adImageView.layer.cornerRadius = 10
        adImageView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }

    private func setupUI() {
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(adImageView)

        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: topAnchor),
            adImageView.leftAnchor.constraint(equalTo: leftAnchor),
            adImageView.rightAnchor.constraint(equalTo: rightAnchor),
            adImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(image: UIImage) {
        adImageView.image = image
        adImageView.contentMode = .scaleAspectFill
    }
}
