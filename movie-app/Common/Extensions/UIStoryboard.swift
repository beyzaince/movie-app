//
//  UIViewController+Extensions.swift
//  movie-app
//
//  Created by beyza on 23.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit


extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        case detail
        
        var fileName : String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.fileName, bundle: nil)
    }
    
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            
        }
        
        return viewController
    }
}
