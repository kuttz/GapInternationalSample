//
//  EndPoint.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

let baseURL: String = "https://gapinternationalwebapi20200521010239.azurewebsites.net"

enum EndPoint {
    case register
    case login
    case getJournal
    case saveJournal
    case getChapter
    
    var path: String {
        switch self {
        case .register:
            return "/api/User/CreateUserAccount"
        case .login:
            return "/api/User/UserLogin"
        case .getJournal:
            return "/api/User/GetJournal"
        case .saveJournal:
            return "/api/User/SaveJournal"
        case .getChapter:
            return "/api/User/GetChapter"
        }
    }
    
    var url: URL? {
        URL(string: baseURL + self.path)
    }
    
}
