//
//  TextfieldDesign.swift
//  
//
//
//

import SwiftUI

struct TextfieldDesign: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 380)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.primaryColor, style: StrokeStyle(lineWidth: 2.0)))
    }
}

extension View {
    
    func textfieldDesign() -> some View {
        modifier(TextfieldDesign())
    }
}
