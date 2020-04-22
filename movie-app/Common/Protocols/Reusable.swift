//
//  Reusable.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit


protocol Reusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }
}

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.nib,forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}
