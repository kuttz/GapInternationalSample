//
//  Webservice.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}

protocol WebserviceProtocol: AnyObject {
    func load<T: Codable>(resource: Resource<T>) async throws -> T
}

class Webservice: WebserviceProtocol {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                    throw NetworkError.badUrl
                }
                request = URLRequest(url: url)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
                
        let (data, _) = try await session.data(for: request)
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
                
        return result
    }
    
}
