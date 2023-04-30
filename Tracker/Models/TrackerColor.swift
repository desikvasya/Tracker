//
//  TrackerColor.swift
//  Tracker
//
//  Created by Denis on 23.04.2023.
//

import UIKit

enum MainColor: String {
    case blackYP = "blackYP"
    case whiteYP = "whiteYP"
    case grayYP = "grayYP"
    case lightGrayYP = "lightGrayYP"
    case redYP = "redYP"
    case blueYP = "blueYP"
    case backgroundYP = "backgroundYP"
}

enum SelectionColor: String, CaseIterable {
    case selection01 = "selectionRed"
    case selection02 = "selectionOrange"
    case selection03 = "selectionBlue"
    case selection04 = "selectionPurple"
    case selection05 = "selectionGreen"
    case selection06 = "selectionPink"
    case selection07 = "selectionTranslucentPink"
    case selection08 = "selectionLightBlue"
    case selection09 = "selectionLightGreen"
    case selection10 = "selectionDeepPurple"
    case selection11 = "selectionScandalousOrange"
    case selection12 = "selectionBrilliantPurplishPink"
    case selection13 = "selectionBeige"
    case selection14 = "selectionCornflower"
    case selection15 = "selectionBluelilac"
    case selection16 = "selectionModerateOrchid"
    case selection17 = "selectionMediumMagenta"
    case selection18 = "selectionGreenOcean"
}

extension UIColor {
    static func mainColorYP(_ color: MainColor) -> UIColor? {
        return UIColor(named: color.rawValue)
    }

    static func selectionColorYP(_ color: SelectionColor) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}


