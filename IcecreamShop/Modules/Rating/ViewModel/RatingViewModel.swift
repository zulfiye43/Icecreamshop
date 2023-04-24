//
//  RatingViewModel.swift
//  
//
//
//

import Foundation
import SwiftUI

class RatingViewModel: ObservableObject {
    
    //    @Published var image: UIImage?
    @Published var flavors: [Flavor] = []
    @Published var currentRating: Int?
    @Published var textFieldName: String = ""
    @Published var textFieldComment: String = ""
    @Published var textFieldAdress: Adress = Adress(street: "", housenumber: "", zipcode: "", city: "")
    @Published var selectedImage = UIImage()
    @Published var showSheet = false
    @Published var showImagePicker: Bool = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    var icecreamShopRepository: IcecreamShopRepository
    
    
    init() {
        self.icecreamShopRepository = IcecreamShopRepositoryImpl.shared
        updateFlavors()
    }
    
    func onRatingItemTapped(rating: Int) {
        currentRating = rating
    }
    
    func onSaveButtonTapped() async {
        
        let availaibleFlavors = flavors.filter { flavor in
            if flavor.flavorState == .marked {
                return true
            } else {
                return false
            }
        }
        
        let icecreamShop = IcecreamShop(
            name: textFieldName,
            comment: textFieldComment,
            rating: currentRating ?? 1,
            adress: textFieldAdress,
            imageData: selectedImage.pngData(),
            availableFlavors: availaibleFlavors
        )
        await icecreamShopRepository.addIcecreamShop(icecreamShop: icecreamShop)
    }
    
    
    func onFlavorButtonTapped(flavor: Flavor) {
        
        let flavorIndex = flavors.firstIndex { flavorInArray in
            flavorInArray.id == flavor.id
        }
        guard let index = flavorIndex else {
            return
        }
        switch flavor.flavorState {
            
        case .notMarked:
            flavors[index].flavorState = .marked
        case .marked:
            flavors[index].flavorState = .notMarked
        }
    }
    
    private func updateFlavors() {
        NetworkService.shared.request("flavors.json", type: [Flavor].self) { result in
            switch result {
            case .success(let flavorsFromJson):
                self.flavors = flavorsFromJson
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
}
