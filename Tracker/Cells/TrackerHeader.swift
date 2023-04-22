//
//  TrackerHeader.swift
//  Tracker
//
//  Created by Denis on 18.04.2023.
//

import UIKit

final class TrackerHeader: UICollectionReusableView {

    static let reuseIdentifier = "trackerHeader"

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(categoryLabel)

        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
