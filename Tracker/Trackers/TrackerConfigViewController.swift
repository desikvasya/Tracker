//
//  TrackerConfigViewController.swift
//  Tracker
//
//  Created by Denis on 29.04.2023.
//

import UIKit


final class TrackerConfigViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CreateTrackerVCDelegate?


    var collectionView: UICollectionView! = nil

    private let emojis = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶",
        "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]

    private let trackerType: [String] = ["Категория","Расписание"]

    var selectedTitle: String?
    var selectedCategory: TrackerCategory?
    var selectedShedule = [WeekDay]()
    var selectedEmoji: String?
    var selectedColor: SelectionColor?

    var selectedEmojiIndexPath: IndexPath?
    var selectedColorIndexPath: IndexPath?

    var readyButton: Button?



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureCollectionView()
    }

    func configureCollectionView() {

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())

        // Register
        collectionView.register(
            Header.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Header.reuseIdentifier
        )
        collectionView.register(
            EmojiCell.self,
            forCellWithReuseIdentifier: EmojiCell.reuseIdentifier
        )
        collectionView.register(
            ListCell.self,
            forCellWithReuseIdentifier: ListCell.reuseIdentifier
        )
        collectionView.register(
            InputCell.self,
            forCellWithReuseIdentifier: InputCell.reuseIdentifier)
        collectionView.register(
            ColorCell.self,
            forCellWithReuseIdentifier: ColorCell.reuseIdentifier)

        // Setup UI
        collectionView.backgroundColor = UIColor.white

        let title: UILabel = {
            let label = UILabel()
            label.text = "Новая привычка"
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let cancelButton = Button(type: .cancel, title: "Отменить") {
            self.dismiss(animated: true)
        }


        readyButton = Button(type: .primary(isActive: false), title: "Готово", tapHandler: {
            self.delegate?.didCreateNewTracker(newCategory: self.createNewTracker())
            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                rootVC.dismiss(animated: true, completion: nil)
            }
        })

        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.backgroundColor = .white
            stack.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
            stack.isLayoutMarginsRelativeArrangement = true
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 8
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        view.addSubview(title)
        view.addSubview(hStack)

        hStack.addArrangedSubview(cancelButton)
        hStack.addArrangedSubview(readyButton!)

        let vInset: CGFloat = 38
        let hInset: CGFloat = 20

        NSLayoutConstraint.activate([

            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),

            collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: vInset),
            collectionView.bottomAnchor.constraint(equalTo: hStack.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hInset),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -hInset)
        ])

        collectionView.delegate = self
        collectionView.dataSource = self

    }

    func generateLayout() -> UICollectionViewLayout {

        let inputLayout = createInputLayout()
        let listLayout = createListLayout()
        let emojiLayout = createEmojiLayout()
        let colorLayout = createColorLayout()

        return UICollectionViewCompositionalLayout { (sectionNumber, env) ->
            NSCollectionLayoutSection? in

            switch sectionNumber {
            case 0: return inputLayout
            case 1: return listLayout
            case 2: return emojiLayout
            case 3: return colorLayout
            default:
                fatalError("Unsupported section in generateLayout")
            }
        }
    }

}


extension TrackerConfigViewController {

    func createInputLayout() -> NSCollectionLayoutSection {

        let height: CGFloat = 75
        let hInset: CGFloat = 16

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: hInset, bottom: 0, trailing: hInset)

        return section
    }

    func createListLayout() -> NSCollectionLayoutSection {

        let height: CGFloat = 75
        let hInset: CGFloat = 16

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height+height))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: hInset, bottom: 32, trailing: hInset)

        return section

    }

    func createEmojiLayout() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/6),
            heightDimension: .fractionalWidth(1/6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/6))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])


        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 18, bottom: 24, trailing: 18)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(18))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        return section

    }

    func createColorLayout() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/6),
            heightDimension: .fractionalWidth(1/6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(46))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 18, bottom: 24, trailing: 18)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(18))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        return section

    }
}

// MARK: - EXTENTIONS

extension TrackerConfigViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int { 4 }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return emojis.count
        case 3: return SelectionColor.allCases.count
        default: fatalError("Unsupported section in numberOfItemsInSection")
        }
    }

    // Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return inputCell(for: indexPath, collectionView: collectionView)
        case 1:
            return listCell(for: indexPath, collectionView: collectionView)
        case 2:
            return emojiCell(for: indexPath, collectionView: collectionView)
        case 3:
            return colorCell(for: indexPath, collectionView: collectionView)
        default:
            fatalError("Unsupported section in cellForItemAt")
        }
    }

    func inputCell(for indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let inputCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InputCell.reuseIdentifier,
            for: indexPath) as! InputCell

        inputCell.userInputField.placeholder = "Введите название трекера"

        inputCell.textFieldValueChanged = { inputText in
            self.selectedTitle = inputText

            self.isTrackerReadyToBeCreated()
        }

        return inputCell
    }

    func listCell(for indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let listCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCell.reuseIdentifier,
            for: indexPath) as! ListCell

        if indexPath.item == 0 {
            listCell.buttonPosition = .first
            listCell.subtitleLabel.text = selectedCategory?.name
        } else if indexPath.item == 1 {
            listCell.buttonPosition = .last
            if !selectedShedule.isEmpty {
                let days = selectedShedule.map { $0.shortLabel }
                print("DAYS \(days)")
                let daysString = days.joined(separator: ", ")
                listCell.subtitleLabel.text = daysString
            }
        }

        listCell.titleLabel.text = trackerType[indexPath.item]

        return listCell
    }

    func emojiCell(for indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let emojiCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiCell.reuseIdentifier,
            for: indexPath) as! EmojiCell

        emojiCell.emojiLabel.text = emojis[indexPath.row]
        emojiCell.backgroundShape.layer.cornerRadius = 16

        return emojiCell
    }

    func colorCell(for indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let colorCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorCell.reuseIdentifier,
            for: indexPath) as! ColorCell

        return colorCell
    }

    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: Header.reuseIdentifier,
            for: indexPath) as! Header

        switch indexPath.section {

        case 0, 1: header.isHidden = true
        case 2: header.sectionLabel.text = "Emoji"
        case 3: header.sectionLabel.text = "Цвет"
        default:
            fatalError("Unsupported section in viewForSupplementaryElementOfKind")
        }
        return header
    }
}


extension TrackerConfigViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.section == 3 {
            if let selectionCell = cell as? ColorCell {
                let selectionColor = SelectionColor.allCases[
                    indexPath.row % SelectionColor.allCases.count]
                selectionCell.innerShape.backgroundColor = UIColor.selectionColorYP(selectionColor)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.section {

        case 0: handleListSelection(at: indexPath)
        case 1: handleEmojiSelection(at: indexPath)
        case 2: handleColorSelection(at: indexPath)
        default: break
        }

        collectionView.deselectItem(at: indexPath, animated: false)

    }

    private func handleListSelection(at indexPath: IndexPath) {

        if indexPath.row == 0 {
            let vc = CategoryViewController()
            present(vc, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let vc = SchedulerViewController(selectedDays: selectedShedule)
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }

    private func handleEmojiSelection(at indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell else { return }

        if let selectedCell = collectionView.cellForItem(at: selectedEmojiIndexPath ?? IndexPath(item: -1, section: 0)) as? EmojiCell {
            selectedCell.backgroundShape.backgroundColor = UIColor.clear
        }

        cell.backgroundShape.backgroundColor = UIColor.mainColorYP(.lightGrayYP)

        selectedEmojiIndexPath = indexPath
        selectedEmoji = emojis[indexPath.row]

        isTrackerReadyToBeCreated()
    }

    private func handleColorSelection(at indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else { return }

        let colorIndex = indexPath.row % SelectionColor.allCases.count
        let color = UIColor.selectionColorYP(SelectionColor.allCases[colorIndex])

        if let selectedColorIndexPath = collectionView.cellForItem(at: selectedColorIndexPath ?? IndexPath(item: -1, section: 0)) as? ColorCell {
            selectedColorIndexPath.backgroundShape.layer.borderColor = UIColor.clear.cgColor
        }

        cell.backgroundShape.layer.borderColor = color?.withAlphaComponent(0.3).cgColor

        selectedColorIndexPath = indexPath
        selectedColor = SelectionColor.allCases[indexPath.row]

        isTrackerReadyToBeCreated()
    }

}


// MARK: - AddSchedulerDelegate

extension TrackerConfigViewController: AddSchedulerDelegate {

    func didUpdateSelectedDays(selectedDays: [WeekDay]) {
        self.selectedShedule = selectedDays

        isTrackerReadyToBeCreated()
        let sectionToReload = 1
        collectionView.reloadSections(IndexSet(integer: sectionToReload))
    }
}



extension TrackerConfigViewController {

    func isTrackerReadyToBeCreated() {
        guard let title = selectedTitle, !title.isEmpty,
              let emoji = selectedEmoji,
              let color = selectedColor,
              !selectedShedule.isEmpty else {
            readyButton?.isActive = false
            return
        }
        readyButton?.isActive = true
    }

    func createNewTracker() -> TrackerCategory {
        let title: String = selectedTitle!
        let emoji: String = selectedEmoji!
        let color: UIColor = UIColor.selectionColorYP(selectedColor!)!
        let day: Set<WeekDay>? = Set(selectedShedule)


        let newTracker = TrackerModel(title: title, emoji: emoji, color: color, day: day)

        let newCategory = TrackerCategory(name: selectedCategory?.name ?? "", trackers: [newTracker])
        
        return newCategory
    }
}




// MARK: - PROTOCOL


protocol CreateTrackerVCDelegate: AnyObject {
    func didCreateNewTracker(newCategory: TrackerCategory)
}
