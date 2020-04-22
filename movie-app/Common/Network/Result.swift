//
//  Result.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import Foundation
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
