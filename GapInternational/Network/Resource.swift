//
//  Resource.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod = .post(nil)
}
