//
//  Header.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import UIKit

final class Header: UICollectionReusableView {

    static let reuseIdentifier = "header"

    let sectionLabel: UILabel = {
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
        addSubview(sectionLabel)

        let hInset: CGFloat = 12

        NSLayoutConstraint.activate([
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hInset),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -hInset),
            sectionLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
