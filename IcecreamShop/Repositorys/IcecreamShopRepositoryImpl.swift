//
//  IcecreamShopRepositoryImpl.swift
//  
//
//
//

import SwiftUI

struct IcecreamShopRepositoryImpl: IcecreamShopRepository {
    
    static let shared = IcecreamShopRepositoryImpl()
    
    
    func loadIcecreamShops() async -> [IcecreamShop] {
        guard
            let data = UserDefaults.standard.data(forKey: "icecreamshops"),
            let decodedIcecreamShops = try? JSONDecoder().decode([IcecreamShop].self, from: data)
        else { return [] }
        //print(decodedIcecreamShops)
        return decodedIcecreamShops
    }
    
    func deleteIcecreamShop(icecreamShop: IcecreamShop) {
        Task {
            var icecreamShops = await loadIcecreamShops()
            guard let index = icecreamShops.firstIndex(of: icecreamShop) else {return}

            icecreamShops.remove(at: index)

            if let encodedIcecreamShop = try? JSONEncoder().encode(icecreamShops) {
                UserDefaults.standard.set(encodedIcecreamShop, forKey: "icecreamshops")
            }
        }
    }

    func addIcecreamShop(icecreamShop: IcecreamShop) async {
       
            var icecreamShops = await loadIcecreamShops()
            
            icecreamShops.append(icecreamShop)
            
            if let encodedIcecreamShop = try? JSONEncoder().encode(icecreamShops) {
                UserDefaults.standard.set(encodedIcecreamShop, forKey: "icecreamshops")
            }
    }
}
