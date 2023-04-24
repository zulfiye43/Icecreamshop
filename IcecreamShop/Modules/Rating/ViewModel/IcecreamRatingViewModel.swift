//
//  IcecreamRatingViewModel.swift
//  einarbeitung-zuelfiye
//
//  Created by Cakmak, Zülfiye on 27.09.22.
//

import Foundation


class IcecreamRatingViewModel: ObservableObject {
    
    @Published var rating: Int?
    
    // name ändern
     func starType(index: Int) -> String {
        if let rating = self.rating {
            return index <= rating ? "star.fill" : "star"
        } else {
            return "star"
        }
    }
}
    
