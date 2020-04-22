//
//  APIMethod.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

protocol APIMethod {
    var base: String { get }
    var path: String { get }
    var parameters: Parameters { get }
    
}
extension APIMethod {
    
    var queryParam : String {
        return parameters.map{ $0.0 + "=" + $0.1 }.joined(separator: "&")
    }
    
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = queryParam
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
