//
//  ColorCell.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import UIKit

final class ColorCell: UICollectionViewCell {

    static let reuseIdentifier = "colorCell"


    let backgroundShape: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 3
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let innerShape: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor.magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorCell {

    private func configure() {
        contentView.addSubview(backgroundShape)
        backgroundShape.addSubview(innerShape)

        let inset: CGFloat = 6

        NSLayoutConstraint.activate([

            backgroundShape.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundShape.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundShape.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundShape.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            innerShape.leadingAnchor.constraint(equalTo: backgroundShape.leadingAnchor, constant: inset),
            innerShape.trailingAnchor.constraint(equalTo: backgroundShape.trailingAnchor, constant: -inset),
            innerShape.topAnchor.constraint(equalTo: backgroundShape.topAnchor, constant: inset),
            innerShape.bottomAnchor.constraint(equalTo: backgroundShape.bottomAnchor, constant: -inset),
        ])
    }
}
