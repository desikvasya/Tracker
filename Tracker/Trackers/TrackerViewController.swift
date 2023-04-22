//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Denis on 17.04.2023.
//

import UIKit

final class TrackersViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {

    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//    private var categories: [TrackerCategory] = []
    
    private lazy var placeholderView: UIView = .placeholderView(
        message: "Что будем отслеживать?",
        icon: .trackerStartPlaceholder
    )
    
    internal
    
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        configureNavigationBar()
        addPlaceholder()
    }
    
    
    @objc private func addNewTracker() {
        let vc = NewTrackerViewController()
        vc.trackersViewController = self
        present(vc, animated: true)
    }

    // MARK: - UI Components

    private lazy var addButton: UIBarButtonItem = {
        let addIcon = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )

        let addButton = UIBarButtonItem(
            image: addIcon,
            style: .plain,
            target: self,
            action: nil
        )

        addButton.tintColor = .black
        addButton.action = #selector(addNewTracker)

        return addButton
    }()
//
//    private lazy var datePicker: YPDatePicker = {
//        let picker = YPDatePicker()
//
//        picker.datePickerMode = .date
//        picker.preferredDatePickerStyle = .compact
//
//        picker.addTarget(self, action: #selector(dateSelected(_:)), for: .valueChanged)
//
//        picker.translatesAutoresizingMaskIntoConstraints = false
//
//        return picker
//    }()

    private lazy var searchField: UISearchController = {
        let search = UISearchController()

        search.delegate = self
        search.searchBar.delegate = self

        return search
    }()

//    private lazy var collectionView: UICollectionView = {
//        let collection = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: UICollectionViewCompositionalLayout.trackers
//        )
//
//        collection.keyboardDismissMode = .onDrag
//        collection.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
//
//        collection.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//
//        collection.register(
//            YPSectionHeaderCollectionView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: "\(YPSectionHeaderCollectionView.self)"
//        )
//
//        collection.alwaysBounceVertical = true
//
//        return collection
//    }()

    private lazy var startPlaceholderView: UIView = {
        let view = UIView.placeholderView(
            message: "Что будем отслеживать?",
            icon: .trackerStartPlaceholder
        )

        view.alpha = 0

        return view
    }()

    private lazy var emptyPlaceholderView: UIView = {
        let view = UIView.placeholderView(
            message: "Ничего не найдено",
            icon: .trackerEmptyPlaceholder
        )

        view.alpha = 0

        return view
    }()

}

// MARK: - Appearance

private extension TrackersViewController {

    func configureNavigationBar() {
        title = "Трекеры"

        navigationItem.leftBarButtonItem = addButton
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchField
    }

    func setupAppearance() {
        view.backgroundColor = .white

        view.addSubview(startPlaceholderView)
        view.addSubview(emptyPlaceholderView)

        NSLayoutConstraint.activate([
            startPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

private extension TrackersViewController {
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


