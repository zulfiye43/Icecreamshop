//
//  PrimaryColor.swift
//  
//
//
//

import SwiftUI

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
    static let primaryColor = Color(red: 0.824, green: 0.855, blue: 1)
    static let offWhite = Color(red: 0.824, green: 0.855, blue: 1) // #d2daff
    static var blackOpacity = Color.black.opacity(0.2)
    static var whiteOpacity = Color.white.opacity(0.7)
    static var transparent = Color.white.opacity(0)

}
