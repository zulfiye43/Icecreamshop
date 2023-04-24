//
//  SideMenuViewModel.swift
//  
//
//
//

import SwiftUI

class SideMenuViewModel: ObservableObject {
    
    @Published var isMenuOpen: Bool = false
    
    func openMenu() {
        self.isMenuOpen = true
    }
    
    func closeMenu() {
        self.isMenuOpen = false
    }
    
    func onMenuTapped() {
        isMenuOpen = false
    }
}
