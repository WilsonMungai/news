//
//  SearchViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit

class SearchViewController: UIViewController {
    
    // search controller
    private let searchController: UISearchController = {
        // Creates and returns a search controller with the specified view controller for displaying the results.
        let controller = UISearchController()
        // search bar placeholder
        controller.searchBar.placeholder = "Search for articles"
        // search bar style
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        
        // integrate the search controller onto the naivagation stack
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else {
                  return
              }
//        resultsController.delegate = self
        APICaller.shared.search(with: query) { result in
            switch result {
            case .success(let articles):
                resultsController.article = articles
                resultsController.searchResultTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
}
