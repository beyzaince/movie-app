//
//  MovieListViewModel.swift
//  movie-app
//
//  Created by beyza on 22.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit


protocol MovieListViewModelProtocol {
    
    var viewDelegate: MovieListViewModelViewDelegeate? { get set }
    
    // MARK: - Data Source
    var shouldHideNavigationBar: Bool { get }
    
    // MARK: - Events
    func start()
    
    func movieCount() -> Int
    
    func getMovie(row: Int) -> Movie
    
    func setSearchValue(param: String)
    
}

protocol MovieListViewModelType {}

protocol MovieListViewModelViewDelegeate: class {
    
    func updateScreen()
    
}


class MovieListViewModel {
    
    // MARK: - Delegates
    weak var viewDelegate: MovieListViewModelViewDelegeate?
    
    
    // MARK: - Properties
    private var api: API!
    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var searchParam: String = ""
    
    private var isSearching = false
    
    private var page: Int = 1
    
    // MARK: - Init
    init(api: API) {
        self.api = api
    }
    
    // MARK: - Network
    func getMovies() {
        api.getMovieList(from: .topRated(page: self.page)) { result in
            switch result {
            case .success(let movieFeedResult):
                guard let movieResults = movieFeedResult?.results else { return }
                self.movies.append(contentsOf: movieResults)
            case .failure(let error):
                print("the error \(error)")
            }
            self.filterMovies(param:self.searchParam)
        }
        
    }
    
    
    func filterMovies(param: String) {
        if self.searchParam.count > 0 {
            self.filteredMovies = self.movies.filter({($0.title?.lowercased().contains(self.searchParam.lowercased()) ?? false)})
        } else {
            self.filteredMovies = self.movies
        }
        
        self.viewDelegate?.updateScreen()
    }
}


extension MovieListViewModel: MovieListViewModelProtocol {
    
    
    var shouldHideNavigationBar: Bool {
        return true
    }
    
    func start() {
        getMovies()
    }
    
    func movieCount() -> Int {
        return self.filteredMovies.count
    }
    
    func getMovie(row: Int) -> Movie {
        return self.filteredMovies[row]
    }
    
    func loadMore() {
        self.page += 1
        getMovies()
    }
    
    func setSearchValue(param: String) {
        self.searchParam = param
        self.filterMovies(param: self.searchParam)
    }
    
}
