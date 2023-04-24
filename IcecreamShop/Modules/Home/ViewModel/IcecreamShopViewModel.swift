//
//  IcecreamShopViewModel.swift
//  
//
//
//

import SwiftUI

class IcecreamShopViewModel: ObservableObject {
    @Published var isExtended = false
    
    func onItemTapped() {
        isExtended.toggle()
    }
}
