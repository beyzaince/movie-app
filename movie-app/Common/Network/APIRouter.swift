//
//  APIRouter.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation

enum APIRouter {
    case movieDetail(id: Int)
    case topRated(page: Int)
}
extension APIRouter: APIMethod {
    
    var base: String {
        return Environment.BaseURL.test
    }
    
    var path: String {
        switch self {
        case .movieDetail(let id):
            return "/3/movie/" + "\(id)"
        case .topRated:
            return "/3/movie/top_rated"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .movieDetail:
            return ["api_key": Environment.apiKey.test]
        case .topRated(let page):
            return ["api_key": Environment.apiKey.test,"page": String(page)]
        }
    }
    
}
