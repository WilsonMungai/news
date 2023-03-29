//
//  SearchViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
    
    private var articles: [Article] = [Article]()
    
    private var viewModel = [TopNewsViewCellViewModel]()
    
    // instance of search view controller
    private let searchVC = UISearchController(searchResultsController: nil)
    
    // MARK: - UI Elements
    private let searchTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchTable)
        
        setupTable()
        
        createSearchViewController()
    }
    // table view frame
    override func viewDidLayoutSubviews() {
        searchTable.frame = view.bounds
    }
    
    // MARK: - Private methods
    private func setupTable() {
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    // setup search view controller
    private func createSearchViewController() {
        // add seach vc to navogation stack
        navigationItem.searchController = searchVC
        // be notified when user taps on the search bar
        searchVC.searchBar.delegate = self
    }
}

// MARK: - Table view extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // number of articles returned
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    // data to be displayed in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell  else { return UITableViewCell() }
        let article = articles[indexPath.row]
        let title = article.title ?? ""
        let source = article.source.name
        let image = URL(string: article.urlToImage ?? "")
        cell.configure(viewModel: TopNewsViewCellViewModel(title: title,
                                                           source: source,
                                                           imageUrl: image))
        cell.selectionStyle = .none
        return cell
    }
    // row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // navigate to safari browser
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = articles[indexPath.row].url else { return }
        guard let articleUrl = URL(string: article) else { return }
        let vc = SFSafariViewController(url: articleUrl)
        present(vc, animated: true)
    }
}
// MARK: - Search extension
extension SearchViewController: UISearchBarDelegate {
    // notify delegate search button was clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        print(query)
        APICaller.shared.search(with: query) { [weak self] result in
            switch result {
            case .success(let article):
                // hook up articles returned the array of articles
                self?.articles = article
                DispatchQueue.main.async {
                    self?.searchTable.reloadData()
                    self?.searchVC.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
