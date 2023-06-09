//
//  Cat.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import Foundation

struct Cat: Decodable {
    let breedName: String?
    let origin: String?
    let affectionLevel: Int?
    let intelligence: Int?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case breedName = "name"
        case origin
        case affectionLevel = "affection_level"
        case intelligence
        case imageUrl = "reference_image_id"
    }
}
