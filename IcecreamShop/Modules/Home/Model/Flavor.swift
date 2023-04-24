//
//  IcecreamCategory.swift
//  
//
//
//

import SwiftUI


public struct Flavor: Decodable {
    
    public let image: Image
    public let title: String
    public let id: Int
    public var flavorState: FlavorState
    
    public enum CodingKeys: String, CodingKey {
        case imageName
        case title
        case id
        //      case flavorState
    }
    
    public init(image: Image, title: String, id: Int) {
        self.image = image
        self.title = title
        self.id = id
        self.flavorState = .notMarked
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        let imageName = try container.decode(String.self, forKey: CodingKeys.imageName)
        self.image = Image(imageName)
        self.flavorState = .notMarked // try container.decode(FlavorState.self, forKey: .flavorState)
        
    }
}
