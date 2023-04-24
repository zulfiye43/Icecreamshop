//
//  IcecreamShopRepository.swift
// 
//
//
//

import Foundation

/// das Protokoll dient als Schnittstelle zum IcecreamshopRepositoryImpl 
protocol IcecreamShopRepository {
    
    /// loadIcecreamShops lädt  alle icecreamShops und gibt den IcecreamShop als Array zurück
    func loadIcecreamShops() async -> [IcecreamShop]
    /// deleteIcecreamShop löscht den ausgewählten IcecreamShop
    func deleteIcecreamShop(icecreamShop: IcecreamShop)
    /// addIcecreamShop fügt ein IcecreamShop hinzu
    func addIcecreamShop(icecreamShop: IcecreamShop) async
}
