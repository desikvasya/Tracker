//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Denis on 25.04.2023.
//

import UIKit

final class SchedulerViewController: UIViewController {

    let weekdays = WeekDay.allCases
    var selectedDays = [WeekDay]()
    var onDismiss: (([WeekDay]) -> Void)? // returns selectedDays to CreateTrackerVC

    weak var delegate: AddSchedulerDelegate?

    init(selectedDays: [WeekDay]) {
        self.selectedDays = selectedDays
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("It's time to retire buddy")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColorYP(.whiteYP)
        configure()
    }

    private func configure() {

        let title: UILabel = {
            let label = UILabel()
            label.text = "Расписание"
            label.textColor = UIColor.mainColorYP(.blackYP)
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let tableView: UITableView = {
            let table = UITableView()
            table.register(SchedulerCell.self, forCellReuseIdentifier: SchedulerCell.reuseIdentifier)
            table.delegate = self
            table.dataSource = self
            table.layer.masksToBounds = true
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()

        let doneButton = Button(type: .primary(isActive: true), title: "Готово") {
            [self] in
            delegate?.didUpdateSelectedDays(selectedDays: selectedDays)
            dismiss(animated: true)
        }

        view.addSubview(title)
        view.addSubview(tableView)
        view.addSubview(doneButton)


        let vInset: CGFloat = 38

        NSLayoutConstraint.activate([

            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),

            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: vInset),
            tableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SchedulerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


extension SchedulerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let firstIndex = 0
        let lastIndex = weekdays.count - 1
        let cellID = SchedulerCell.reuseIdentifier

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SchedulerCell else { fatalError("Unable to dequeue \(cellID)") }

        let weekday = weekdays[indexPath.row]

        let isWeekdaySelected = selectedDays.contains(weekday)
        cell.toggleControl.isOn = isWeekdaySelected

        cell.labelMenu.text = weekday.label

        switch (indexPath.row, weekdays.count) {

        case (firstIndex, 1): cell.buttonPosition = .single
        case (firstIndex, _): cell.buttonPosition = .first
        case (lastIndex, _): cell.buttonPosition = .last
        default: cell.buttonPosition = .middle
        }


        cell.toggleValueChanged = { isOn in
            let weekDay = self.weekdays[indexPath.row]
            if isOn {
                self.selectedDays.append(weekDay)
                print("AFTER (+) — \(self.selectedDays)")
            } else {
                if let index = self.selectedDays.firstIndex(of: weekDay) {
                    self.selectedDays.remove(at: index)
                    print("AFTER (-) — \(self.selectedDays)")
                }
            }
        }
        print("SELECTED - \(selectedDays)")
        return cell
    }
}


// MARK: - Protocol

protocol AddSchedulerDelegate: AnyObject {
    func didUpdateSelectedDays(selectedDays: [WeekDay])
}
