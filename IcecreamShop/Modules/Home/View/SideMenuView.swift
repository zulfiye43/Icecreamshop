//
//  SideMenuView.swift
//  
//
//
//

import SwiftUI

// TODO: IR-6 MenuContent soll in eine eigene Datei

struct MenuContent: View {
    
    @ObservedObject var viewModel: RatingViewModel
    @State var isBlur: Bool = false
    
    var body: some View {
        
        VStack {
            ForEach(viewModel.flavors, id: \.id) { flavor in
                Button(action: {
                    viewModel.onFlavorButtonTapped(flavor: flavor)
                }) {
                    if flavor.flavorState == .marked {
                        flavor.image
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 25.0),
                                style: FillStyle()
                            )
                            .modifier(RoundedEdge())
                    } else if flavor.flavorState == .notMarked {
                        flavor.image
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0), style: FillStyle())
                    }
                }
            }
        }
    }
    //            ForEach(viewModel.flavors, id: \.id) { flavor in
    //                FlavorView(flavor: flavor)
}

struct SideMenuView: View {
    @ObservedObject  var viewModel: SideMenuViewModel
    @State private var animationAmount = 1.0
    
    var body: some View {
        
        ZStack {
            if !self.viewModel.isMenuOpen {
                Button(action: {
                    self.viewModel.openMenu()
                    animationAmount += 1
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .opacity(0.5)
                }).buttonStyle(NavBarItemButtonStyle())
            }
            else {
                Button(action: {
                    self.viewModel.closeMenu()
                    animationAmount -= 1
                }, label: {
                    Image(systemName: "xmark")
                        .opacity(0.5)
                }).buttonStyle(NavBarItemButtonStyle())
            }
            menuBarView
        }
    }
    
    private var menuBarView: some View {
        
        ZStack {
            
            EmptyView()
                .background(Color.primaryColor.opacity(0.3))
                .opacity(self.viewModel.isMenuOpen ? 1.0 : 0.0)
                .animation(Animation.easeIn.delay(0.25), value: animationAmount)
                .onTapGesture {
                    self.viewModel.onMenuTapped()
                }
            // TODO: IR-6 click on auf früchte buttons, wenn man getapt hat, sollten die Ränder farbig bleiben. disable beim 2ten Tap
            HStack {
                MenuContent(viewModel: RatingViewModel())
                    .frame(width: 90)
                    .background(
                        Color.primaryColor.opacity(0.8)
                    )
                    .offset(x: viewModel.isMenuOpen ? 0 : -100)
                    .animation( .default, value: animationAmount)
                    .cornerRadius(25)
                    .shadow(color: Color.blackOpacity, radius: 10, x: 10, y: 10)
                    .shadow(color: Color.whiteOpacity, radius: 10, x: -5, y: -5)
                
                Spacer()
            }   .padding(.top, 700)
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(viewModel: SideMenuViewModel())
    }
}
