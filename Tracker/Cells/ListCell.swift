//
//  ListCell.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import UIKit

final class ListCell: UICollectionViewCell {

    static let reuseIdentifier = "listCell"

    var buttonPosition: ListButtonPosition = .middle {
        didSet { updateAppearance() }
    }

    let backgroundShape: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.mainColorYP(.backgroundYP)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let accessoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func updateAppearance() {

        switch buttonPosition {
        case .first:
            backgroundShape.layer.cornerRadius = 16
            backgroundShape.layer.masksToBounds = true
            backgroundShape.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .middle:
            backgroundShape.layer.maskedCorners = []
        case .last:
            backgroundShape.layer.cornerRadius = 16
            backgroundShape.layer.masksToBounds = true
            backgroundShape.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            separator.isHidden = true
        case .single:
            backgroundShape.layer.cornerRadius = 16
            backgroundShape.layer.masksToBounds = true
            separator.isHidden = true
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure() {
        contentView.addSubview(separator)
        contentView.addSubview(backgroundShape)

        backgroundShape.addSubview(accessoryImage)
        backgroundShape.addSubview(vStack)

        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)



        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        let hInset = CGFloat(16)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: backgroundShape.topAnchor, constant: hInset),
            vStack.bottomAnchor.constraint(equalTo: backgroundShape.bottomAnchor, constant: -hInset),
            vStack.leadingAnchor.constraint(equalTo: backgroundShape.leadingAnchor, constant: hInset),
            vStack.trailingAnchor.constraint(equalTo: accessoryImage.leadingAnchor, constant: -hInset),

            accessoryImage.centerYAnchor.constraint(equalTo: backgroundShape.centerYAnchor),
            accessoryImage.widthAnchor.constraint(equalToConstant: 13),
            accessoryImage.heightAnchor.constraint(equalToConstant: 20),
            accessoryImage.trailingAnchor.constraint(equalTo: backgroundShape.trailingAnchor, constant: -hInset),

            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hInset),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hInset),
            separator.heightAnchor.constraint(equalToConstant: 0.5),

            backgroundShape.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundShape.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundShape.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundShape.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    enum ListButtonPosition {
        case first, middle, last, single
    }
}
