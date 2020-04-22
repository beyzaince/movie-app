//
//  NavigationBarView.swift
//  movie-app
//
//  Created by beyza on 21.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit

protocol NavigationBarView {
    
    func setLeftButtons(_ button: UIBarButtonItem)
    func setNavigationTitle(_ title: String)
    
}

extension NavigationBarView where Self: UIViewController {
    
    func setLeftButtons(_ button:UIBarButtonItem ) {
        navigationItem.leftBarButtonItem = button
    }
    
    func setNavigationTitle(_ title: String) {
        let label = UILabel(frame: .zero)
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
}
