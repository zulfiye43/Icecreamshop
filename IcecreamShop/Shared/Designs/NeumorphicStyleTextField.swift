//
//  NeumorphicStyleTextField.swift
//  
//
//
//

import SwiftUI

struct NeumorphicStyleTextField: ViewModifier {
  
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: 0,maxWidth: .infinity) // TO WIDTH: MATCH PARENT
            .foregroundColor(.neumorphictextColor)
            .background(Color.primaryColor)
            .cornerRadius(6)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
        }
}

extension View {
    
    func neumorphicStyleTextField() -> some View {
        modifier(NeumorphicStyleTextField())
    }
}
