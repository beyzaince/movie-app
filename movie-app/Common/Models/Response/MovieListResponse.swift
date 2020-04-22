//
//  MovieListResponse.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {
    let results: [Movie]?
}
