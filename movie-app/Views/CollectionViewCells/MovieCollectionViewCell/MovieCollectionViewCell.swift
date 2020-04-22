//
//  MovieCollectionViewCell.swift
//  movie-app
//
//  Created by beyza on 21.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: MovieListViewModelType) {
        
        guard let viewModel = viewModel as? MovieCollectionViewCell.ViewModel else { return }
        
        self.titleLabel.text = viewModel.title
        self.imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
}


extension MovieCollectionViewCell {
    
    struct ViewModel: MovieListViewModelType {
        var imageUrl: URL?
        var title: String
    }
    
}

extension MovieCollectionViewCell.ViewModel {
    
    init(data: Movie) {
        self.title = data.title ?? ""
        if let url = URL(string: data.imageUrl) {
            self.imageUrl = url
        }
    }
}
