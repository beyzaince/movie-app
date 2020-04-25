//
//  MovieListViewController.swift
//  movie-app
//
//  Created by beyza on 21.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let api: API = API()
    
    lazy var viewModel: MovieListViewModel = {
        var tempModel = MovieListViewModel(api: self.api)
        tempModel.viewDelegate = self
        return tempModel
    }()
    @IBOutlet weak var searchTextField: UITextField!
    
    // We keep track of the pending work item as a property
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    let queue = DispatchQueue.global()
    
    @IBOutlet weak var loadMoreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
        viewModel.start()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(viewModel.shouldHideNavigationBar, animated: false)
    }
    
    func registerCollectionView() {
        collectionView.register(cellType:MovieCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func showDetailView(for movieID: Int) {
   
        let storyboard = UIStoryboard(storyboard: .detail)
        
        let viewController: MovieDetailViewController = storyboard.instantiateViewController()
        viewController.movieID = movieID
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func changeText(text: String) {
        self.viewModel.setSearchValue(param: text.count > 2 ? text : "" )
    }
    
    private func showLoadMoreButton() {
        let visibleCells = collectionView.indexPathsForVisibleItems
        self.loadMoreView.isHidden = visibleCells.filter({$0.row == viewModel.movieCount() - 1}).count > 0 ? false: true
    }
    
    @IBAction func searchFieldDidChange(_ seder: Any) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.changeText(text: self?.searchTextField.text ?? "")
        }
        
        // Save the new work item and execute it after 250 ms
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300),
                                      execute: requestWorkItem)
        
    }

    @IBAction func loadMoreButtonTapped(_ sender: Any) {
        self.loadMoreView.isHidden = true
        self.viewModel.loadMore()
    }
    
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.showLoadMoreButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieID =  viewModel.getMovie(row: indexPath.row).id else { return }
        showDetailView(for: movieID)
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movieCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(viewModel: MovieCollectionViewCell.ViewModel(data: viewModel.getMovie(row: indexPath.row)))
        return cell
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2 ) - 26
        return CGSize(width: width, height: 200)
    }
    
    
}

extension MovieListViewController : MovieListViewModelViewDelegeate {
    func updateScreen() {
        self.collectionView.reloadData()
    }
}
