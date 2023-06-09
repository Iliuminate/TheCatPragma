//
//  BaseServiceManager.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import Foundation

struct ObjectResponse<T: Decodable>: Decodable {
    let data: T?
}

struct ArrayResponse<T: Decodable>: Decodable {
    let data: [T]?
    
//    enum CodingKeys: String, CodingKey {
//        case data
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.data = try? container.decode([T].self, forKey: .data)
//    }
}

struct ArrayDetailsResponse<T: Decodable, D: Decodable>: Decodable {
    let data: [T]?
    let details: D?
    
    enum CodingKeys: String, CodingKey {
        case data
        case details
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decode([T].self, forKey: .data)
        self .details = try? container.decode(D.self, forKey: .details)
    }
}

struct ErrorResponse<E: Decodable>: Decodable {
    let errors: [E]?
}
