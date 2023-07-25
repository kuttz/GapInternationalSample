//
//  Response.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

struct Response<T: Codable>: Codable {
    
    let result: T
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

extension Response where T == String {
    var isSuccess: Bool {
        result.lowercased() == "success"
    }
}
