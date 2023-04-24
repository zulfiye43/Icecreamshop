//
//  HomeViewModel.swift
//  
//
//
//

import Foundation
import Combine
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published
    var isSidebarOpened: Bool = false
    
    @Published
    var showOnlyFullPoints: Bool = false {
        willSet {
            if(!showOnlyFullPoints) {
                filteredShops = icecreamShops.filter { shop in
                    return shop.rating == 5
                }
            }
            else {
                filteredShops = icecreamShops
            }
            
        }
    }
    
    var flavors: [Flavor] = []
    
    @Published
    var filteredShops:[IcecreamShop] = []
    var icecreamShops: [IcecreamShop] = []
    
    private var icecreamShopRepository: IcecreamShopRepository
    
    init() {
        self.icecreamShopRepository = IcecreamShopRepositoryImpl.shared
        self.loadFlavors()
    }
    
    func onAppear() {
        setIcecreamShops()
    }
    
    func onIcecreamShopItemTapped(_ icecreamShop: IcecreamShop) {
        removeIcecreamShop(icecreamShop: icecreamShop)
        setIcecreamShops()
    }
    
    @MainActor
    private func setIcecreamShops() {
        Task {
            icecreamShops = await icecreamShopRepository.loadIcecreamShops()
            filteredShops = icecreamShops
        }
    }
    
    private func removeIcecreamShop(icecreamShop: IcecreamShop) {
        icecreamShopRepository.deleteIcecreamShop(icecreamShop: icecreamShop)
    }
    
    
    
    func removeShop(_ indexSet: IndexSet) {
        indexSet.forEach { i in
            let shop = icecreamShops.remove(at: i)
            icecreamShopRepository.deleteIcecreamShop(icecreamShop: shop) // should be added async await
        }
    }
    
    func getFlavor(id: Int) -> Flavor {
        guard let index = flavors.firstIndex(
            where: {
                $0.id == id
            }
        )
        else {
            return Flavor(image: Image(systemName: ""), title: "", id: 1)
        }
        return flavors[index]
    }
    
    private func loadFlavors() {
        NetworkService.shared.request("flavors.json", type: [Flavor].self) { result in
            switch result {
            case .success(let flavorsFromJson):
                self.flavors = flavorsFromJson
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
    
    @MainActor
    func filterCallBack(_ filters: [Int]) {
        DispatchQueue.main.async { [self] in
            if(filters.isEmpty) {
                filteredShops = icecreamShops
            }
            else {
                let res = icecreamShops.filter { shop in
                    var result = false
                    for id in filters {
                        if(shop.availableFlavorIds.contains(id)) {
                            result = true
                            break
                        }
                    }
                    return result
                }
                filteredShops = res
            }
        }
    }
}
