//
//  HomeViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit
import ProgressHUD
import SafariServices

class TopNewsViewController: UIViewController {
    static let identifier = "TopNewsViewController"
    // object of article model
    private var articles: [Article] = [Article]()
    
    // dynamic title date
    let header = Date().formatted(.dateTime.month(.wide).day())
    
    
    
    // MARK: - UI Elements
    // top news table
    private let topNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        
        view.addSubview(topNewsTable)
        
        tableSetup()
        
        ProgressHUD.show()
        
        fetchData()
        
    }
    // table view frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topNewsTable.frame = view.bounds
    }
    
    // MARK: - Private methods
    private func tableSetup() {
        topNewsTable.dataSource = self
        topNewsTable.delegate = self
        title = "News, \(header)"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "title") ??  ""]
    }
    
    // method that calls api to retreive data
    private func fetchData() {
        APICaller.shared.getTopCanadianNews { [weak self] result in
            switch result {
            case .success(let articles):
                // hook up articles returned the array of articles
                self?.articles = articles
                ProgressHUD.dismiss()
                DispatchQueue.main.async {
                    // reload table view
                    self?.topNewsTable.reloadData()
                }
            case .failure(let error):
                ProgressHUD.show()
                print(error)
            }
        }
    }
}
// MARK: - Table view extension
extension TopNewsViewController: UITableViewDelegate, UITableViewDataSource {
    // number of articles returned
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    // data to be displayed in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else { return UITableViewCell()}
        guard let titleNews = articles[indexPath.row].title else { return UITableViewCell() }
        let imageNews = URL(string: articles[indexPath.row].urlToImage ?? "")
        cell.configure(viewModel: TopNewsViewCellViewModel(title: titleNews,
                                                           source: articles[indexPath.row].source.name,
                                                           imageUrl: imageNews))
        return cell
    }
    
    // row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // navigate to safari browser
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = articles[indexPath.row]
        // get article url
        guard let articleUrl = URL(string: url.url ?? "") else {return}
        // show the safari browser with the article url
        let vc = SFSafariViewController(url: articleUrl)
        present(vc, animated: true)
    }
}
