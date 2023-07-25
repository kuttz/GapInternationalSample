//
//  User.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

struct User: Codable {
    
    let userName: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case password = "Password"
    }
}

extension User {
    
    func loginRequest() -> Resource<Response<String>>? {
        guard let url = EndPoint.login.url,
        let userData = try? JSONEncoder().encode(self)else {
            return nil
        }
        return Resource(url: url, method: .post(userData))
    }
    
    func registerRequest() -> Resource<Response<String>>? {
        guard let url = EndPoint.register.url,
        let userData = try? JSONEncoder().encode(self)else {
            return nil
        }
        return Resource(url: url, method: .post(userData))
    }
}
