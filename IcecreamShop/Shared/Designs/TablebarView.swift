//
//  TablebarView.swift
//  IcecreamShop
//
//  
//

import SwiftUI

struct TablebarView: ViewModifier {
    @Binding var toggleFilter: Bool
    @Binding var secondaryFilter: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // TODO: IR-13 scrollbar machen und hintergrund sollte nicht anklickbar sein, nur die früchte sind anklickbar
                    Button(
                        action: {toggleFilter.toggle()},
                        label: {
                            let iconName = toggleFilter ? "xmark": "line.3.horizontal"
                            Image(systemName: iconName).opacity(0.5)
                    }).buttonStyle(NavBarItemButtonStyle()).padding(.top, 30)
                }
                
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Home")
                            .font(.custom("Dancing Script", size: 50))
                            .opacity(0.5)
                    }.padding(.top, 30)
                }
                // MARK: vielleicht doch mit navigationbaritems leading, trailing arbeiten?
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            secondaryFilter.toggle()
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.largeTitle)
                                .opacity(secondaryFilter ? 1.0 : 0.4)
                        }.buttonStyle(NavBarItemButtonStyle()).padding(.top, 30)
                    }
                }
            }
            .toolbarBackground(Color.primaryColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}


struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {}
                .modifier(
                    TablebarView(
                        toggleFilter: .constant(false),
                        secondaryFilter: .constant(false)
                    )
                )
        }
    }
}
