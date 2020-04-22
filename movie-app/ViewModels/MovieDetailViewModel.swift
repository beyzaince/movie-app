//
//  MovieDetailViewModel.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit


protocol MovieDetailViewModelProtocol {
    
    var viewDelegate: MovieDetailViewModelViewDelegeate? { get set }
    
    // MARK: - Data Source
    var shouldHideNavigationBar: Bool { get }
    
    // MARK: - Events
    func start()
    
}

protocol MovieDetailViewModelType {}

protocol MovieDetailViewModelViewDelegeate: class {
    
    func updateScreen()
    
}


class MovieDetailViewModel {
    
    // MARK: - Delegates
    weak var viewDelegate: MovieDetailViewModelViewDelegeate?
    
    
    // MARK: - Properties
    private var api: API!
    
    private var movieID: Int = 0
    
    private var movie: MovieDetailResponse!
    
    // MARK: - Init
    init(api: API, movieID: Int) {
        self.api = api
        self.movieID = movieID
    }
    
    // MARK: - Network
    func getMovieDetail() {
        api.getMovieDetail(from: .movieDetail(id: self.movieID)) { result in
            switch result {
            case .success(let response):
                self.movie = response
                break
            case .failure(let error):
                print("the error \(error)")
            }
            self.viewDelegate?.updateScreen()
        }
        
    }
    
}


extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var shouldHideNavigationBar: Bool {
        return false
    }
    
    func start() {
        getMovieDetail()
    }
    
    func getMovie() -> MovieDetailResponse {
        return self.movie
    }
    
}
