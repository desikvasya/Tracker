//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import Foundation

struct TrackerCategory {
    let name: String
    let trackers: [TrackerModel]
    
    init(name: String, trackers: [TrackerModel]) {
        self.name = name
        self.trackers = trackers
    }
}

extension TrackerCategory: Sequence {
    func makeIterator() -> some IteratorProtocol {
        return trackers.makeIterator()
    }
}


extension TrackerCategory{
    var startIndex: Int {
        return trackers.startIndex
    }
    var endIndex: Int {
        return trackers.endIndex
    }
    subscript(index: Int) -> TrackerModel {
        return trackers[index]
    }
}
