//
//  Statistics.swift
//  Tracker
//
//  Created by Denis on 17.04.2023.
//

import UIKit

final class StatisticsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Статистика"
        
        addPlaceholder()
    }
    
    // MARK: - Components
    
    private lazy var placeholderView: UIView = .placeholderView(
        message: "Анализировать пока нечего",
        icon: .statsPlaceholder
    )
}

    // MARK: - Appearance

private extension StatisticsViewController {
    func addPlaceholder() {
        view.backgroundColor = .white
        view.addSubview(placeholderView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            placeholderView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}


extension UIView {
    static func placeholderView(message: String, icon: ImageAsset) ->
    UIView {
        let label = UILabel()
        label.font = .asset(.ysDisplayMedium, size: 12)
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        
        
        let imageView = UIImageView()
        imageView.image = .asset(icon)
        
        let vStack = UIStackView()
        
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(label)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        return vStack
    }
}
