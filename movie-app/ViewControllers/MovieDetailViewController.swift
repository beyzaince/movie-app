//
//  MovieDetailViewController.swift
//  movie-app
//
//  Created by beyza on 21.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, NavigationBarView {
    
    private let api: API = API()
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieRatioLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    
    var movieID : Int = 0
    
    lazy var viewModel: MovieDetailViewModel = {
        var tempModel = MovieDetailViewModel(api: self.api, movieID: self.movieID)
        tempModel.viewDelegate = self
        return tempModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.start()
        
        // Do any additional setup after loading the view.
    }
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(viewModel.shouldHideNavigationBar, animated: false)
    }
    
    private func configure() {
        let movieDetail = viewModel.getMovie()
        
        self.setNavigationTitle(movieDetail.title ?? "")
        self.movieOverviewLabel.text = movieDetail.overview
        self.movieRatioLabel.text = "\(movieDetail.voteAverage ?? 0.0)"
        self.moviePopularityLabel.text = "\(movieDetail.popularity ?? 0.0)"
        
    }
    
}

extension MovieDetailViewController: MovieDetailViewModelViewDelegeate {
    
    func updateScreen() {
        configure()
    }
    
    
}

