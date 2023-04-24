//
//  IcecreamShop.swift
//  
//
//

import SwiftUI

struct IcecreamShop: Identifiable, Codable, Equatable {
    
    var id: String
    let name: String
    let comment: String
    let rating: Int
    let adress: Adress
    var availableFlavorIds: [Int]
    private let imageData: Data?
    var image: UIImage {
        guard let data = imageData else {
            return UIImage()
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    init(name: String, comment: String, rating: Int, adress: Adress, imageData: Data?, availableFlavors: [Flavor]) {
        self.id = UUID().uuidString
        self.name = name
        self.comment = comment
        self.rating = rating
        self.adress = adress
        self.imageData = imageData
        self.availableFlavorIds = availableFlavors.map { $0.id }
    }
}

