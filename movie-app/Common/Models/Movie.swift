//
//  Movie.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String?
    let poster_path: String?
    let overview: String?
    let releaseDate: String?
    let backdrop_path: String?
    let release_date: String?
    let id: Int?  

}

extension Movie {
    var imageUrl : String {
        guard let path = self.poster_path else { return "" }
        return Environment.ImageURL.test + path
    }
}
