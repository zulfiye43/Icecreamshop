//
//  Image+Extension.swift
//  
//
//
//

import SwiftUI

extension Image {
    static func starRatingIcon(index: Int, rating: Int ) -> Image {
        let imageName = index <= rating ? "star.fill" : "star"
        return Image(systemName: imageName)
    }
}
