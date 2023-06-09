//
//  Connections.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import Foundation

struct Connections {
    
    enum BaseEndPoint: String {
        case main = "https://api.thecatapi.com"
    }
    
    enum ApiVersion: String {
        case v1 = "v1"
    }
    
    enum Api: String {
        case breeds = "breeds"
    }
    
    static func urlString(_ api: Api, _ apiVersion: ApiVersion, endPoint: BaseEndPoint = .main) -> String {
        return "\(endPoint.rawValue)/\(apiVersion.rawValue)/\(api.rawValue)"
    }
    
    static func url(_ api: Api, _ apiVersion: ApiVersion, endPoint: BaseEndPoint = .main) -> URL {
        return URL(string: urlString(api, apiVersion, endPoint: endPoint))!
    }
}
