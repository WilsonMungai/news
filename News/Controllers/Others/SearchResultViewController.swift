//
//  SearchResultViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-03-27.
//

import UIKit
import SafariServices

class SearchResultViewController: UIViewController {
    
    var article = [Article]()
    
    public let searchResultTable: UITableView = {
        let table = UITableView()
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultTable)
    }

    // notify view it has received its subviews
    override func viewDidLayoutSubviews() {
        searchResultTable.frame = view.bounds
    }
    
    // MARK: - Private methods
    private func setupTable() {
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
    }
}
// MARK: - Table view extension
extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier,for: indexPath) as? TopNewsTableViewCell else { return UITableViewCell() }
        let article = article[indexPath.row]
        let title = article.title ?? ""
        let source = article.source.name
        let image = article.urlToImage ?? ""
        cell.configure(viewModel: TopNewsViewCellViewModel(title: title,
                                                           source: source,
                                                           imageUrl: URL(string: image)))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = article[indexPath.row]
        guard let articleUrl = URL(string: url.url ?? "") else {return}
        let vc = SFSafariViewController(url: articleUrl)
        present(vc, animated: true)
    }
}
