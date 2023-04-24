//
//  EmptyNeumorphicStyleElement.swift
//  
//
//
//

import SwiftUI

struct EmptyNeumorphicStyleElement: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            //.frame(width: 380, height: 100)
            .frame(minWidth: 0,maxWidth: .infinity)
            .foregroundColor(.neumorphictextColor)
            .background(Color.primaryColor)
            .cornerRadius(6)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

extension View {
    
    func emptyNeumorphicStyleElement() -> some View {
        modifier(EmptyNeumorphicStyleElement())
    }
}
