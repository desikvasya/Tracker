//
//  FontsExtension.swift
//  Tracker
//
//  Created by Denis on 16.04.2023.
//

import UIKit

enum FontAssert: String, CaseIterable {
    case ysDisplayBold = "YSDisplay-Bold"
    case ysDisplayMedium = "YSDisplay-Medium"
    case ysDisplayRegular = "YSDisplay-Regular"
}

extension UIFont {
    static func asset(_ fontAsset: FontAssert, size: CGFloat) -> UIFont {
        let fallback = UIFont.systemFont(ofSize: size)
        let assetFont = UIFont(name: fontAsset.rawValue, size: size)
                                             
        return assetFont ?? fallback
    }
}

