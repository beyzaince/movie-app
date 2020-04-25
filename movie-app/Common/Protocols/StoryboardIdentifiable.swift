//
//  StoryboardIdentifiable.swift
//  movie-app
//
//  Created by beyza on 25.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
