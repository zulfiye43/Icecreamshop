//
//  ButtonSelector.swift
//  IcecreamShop
//
//  Created by Burhan Cabiroğlu on 8.01.2023.
//

import SwiftUI

struct ButtonSelector: ViewModifier {
    let isSelected: Bool
    
    init(isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    func body(content: Content) -> some View {
        if(isSelected) {
            content.clipShape(
                RoundedRectangle(cornerRadius: 25.0),
                style: FillStyle()
            )
            .modifier(RoundedEdge())
        }
        else{
            content
        }
    }
    
    
}


extension View {
    public func stateSelector<S>(_ stateSelector: S) ->  some View where S: ButtonSelector{
        /*return self.modifier(
            ButtonSelector(isSelected: isSelected)
        )*/
    }
}

struct ButtonSelector_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {}.modifier(ButtonSelector(isSelected: false))
        }
    }
}
