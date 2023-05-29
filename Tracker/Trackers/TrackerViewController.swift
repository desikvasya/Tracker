//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Denis on 17.04.2023.

import UIKit

final class TrackerViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var choosenDay = "" // день в формате "понедельник"
    
    var dateString = "" // день в формате "2023/05/07"



    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

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

        // Add placeholder view to the view hierarchy
        view.addSubview(placeholderView)

        // Set up search bar constraints
        view.addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            placeholderView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            searchController.searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    @objc private func addNewTracker() {
        let vc = NewTrackerViewController()
        vc.trackerVC = self
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

//    private lazy var searchField: UISearchController = {
//        let search = UISearchController()
//
//        search.delegate = self
//        search.searchBar.delegate = self
//
//        return search
//    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar

        searchBar.placeholder = "Поиск"
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        if let cancelButton = searchBar.subviews.first(where: { $0 is UIButton }) as? UIButton {
            cancelButton.setTitle("Отменить", for: .normal)
        }


        return searchController
    }()


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

private extension TrackerViewController {

    func configureNavigationBar() {
        title = "Трекеры"
        
        navigationItem.leftBarButtonItem = addButton
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchController
    }


    func setupAppearance() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(startPlaceholderView)
        view.addSubview(emptyPlaceholderView)

        NSLayoutConstraint.activate([
//            datePicker.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            startPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

private extension TrackerViewController {
    func addPlaceholder() {
        view.backgroundColor = .white
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        
        container.addSubview(placeholderView)
        container.addSubview(searchController.searchBar)

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            searchController.searchBar.topAnchor.constraint(equalTo: container.topAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            placeholderView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            placeholderView.topAnchor.constraint(greaterThanOrEqualTo: searchController.searchBar.bottomAnchor, constant: 16)
        ])
    }
}




