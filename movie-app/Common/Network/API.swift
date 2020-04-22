//
//  API.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation
class API: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getMovieList(from router: APIRouter, completion: @escaping (Result<MovieListResponse?, APIError>) -> Void) {
        fetch(with: router.request , decode: { json -> MovieListResponse? in
            guard let result = json as? MovieListResponse else { return  nil }
            return result
        }, completion: completion)
    }
    
    func getMovieDetail(from router: APIRouter, completion: @escaping (Result<MovieDetailResponse?, APIError>) -> Void) {
         fetch(with: router.request , decode: { json -> MovieDetailResponse? in
             guard let result = json as? MovieDetailResponse else { return  nil }
             return result
         }, completion: completion)
     }
    
    
    
}
