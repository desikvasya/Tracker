//
//  ImageAsset.swift
//  Tracker
//
//  Created by Denis on 16.04.2023.
//

import UIKit

enum ImageAsset: String, CaseIterable {
    case onboarding1, onboarding2
}

extension UIImage {
    static func asset(_ imageAsset: ImageAsset) -> UIImage {
        guard let image = UIImage(named: imageAsset.rawValue) else {
            preconditionFailure("Can't find \(imageAsset.rawValue)")
        }
        
        return image
    }
}
