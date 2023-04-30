//
//  WeekDay.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case sunday = 1
    case monday, tuesday, wednesday, thursday, friday, saturday
    
    var label: String {
        switch self {
        case .sunday:
            return "Воскресенье"
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        }
    }
    
    var shortLabel: String {
        switch self {
        case .sunday:
            return "Вс"
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Сб"
        }
    }
}
