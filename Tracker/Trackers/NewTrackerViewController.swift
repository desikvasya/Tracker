//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Denis on 22.04.2023.
//

import UIKit

final class NewTrackerViewController: UIViewController {
    
    var trackersViewController: TrackersViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        
        let title: UILabel = {
            let label = UILabel()
            label.text = "Создание трекера"
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.asset(.ysDisplayMedium, size: 16.0)

            return label
        }()
        
        
         lazy var habitButton: UIButton = {
            let button = UIButton(type: .custom)
            button.backgroundColor = .black
            button.layer.cornerRadius = 16
            let font = UIFont.asset(.ysDisplayMedium, size: 16.0)
            button.setTitle("Привычка", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = font

            return button
        }()
        
        lazy var eventButton: UIButton = {
           let button = UIButton(type: .custom)
           button.backgroundColor = .black
           button.layer.cornerRadius = 16
           let font = UIFont.asset(.ysDisplayMedium, size: 16.0)
           button.setTitle("Нерегулярное событие", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.titleLabel?.font = font

           return button
       }()

        let safeArea = view.safeAreaLayoutGuide

        
        view.backgroundColor = .white
        view.addSubview(eventButton)
        view.addSubview(habitButton)
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            habitButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            eventButton.leadingAnchor.constraint(equalTo: habitButton.leadingAnchor),
            eventButton.trailingAnchor.constraint(equalTo: habitButton.trailingAnchor),
            eventButton.heightAnchor.constraint(equalTo: habitButton.heightAnchor),
            eventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            eventButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -247)
        ])
    }
    
    
    
    
}
