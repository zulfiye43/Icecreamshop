//
//  ViewModifier.swift
//  
//
//
//

import SwiftUI

struct RectangleElement: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(width: 340, height: 120)
            .background(Color.offWhite)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}

extension View {
    
    func rectangleElement() -> some View {
        modifier(RectangleElement())
    }
}
