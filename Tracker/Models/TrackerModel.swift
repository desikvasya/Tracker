//
//  TrackerModel.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import UIKit

struct TrackerModel {
    let id = UUID()
    let title: String
    let emoji: String
    let color: UIColor
    let day: Set<WeekDay>?
}
