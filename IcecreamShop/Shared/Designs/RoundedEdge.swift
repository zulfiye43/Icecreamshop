//
//  RoundedEdge.swift
//  einarbeitung-zuelfiye
//
//  
//

import SwiftUI

struct RoundedEdge: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(red: 0.553, green: 0.62, blue: 1))
            .frame(width: 60, height: 60)
            .cornerRadius(40)
    }
}

extension View {
    
    func roundedEdge() -> some View {
        modifier(RoundedEdge())
    }
}
