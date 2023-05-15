//
//  TrendingApplesNewsViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-26.
//

import UIKit
import ProgressHUD
import SafariServices

class TrendingApplesNewsViewController: UIViewController {
    
    // object of article model
    private var articles: [Article] = [Article]()
    
    // dynamic title date
//    let header = Date().formatted(.dateTime.month(.wide).day())
    
    let appleNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(appleNewsTable)
        
        view.backgroundColor = .systemBackground
        
        setupTable()
        
        ProgressHUD.show()
        
        fetchData()
    }
    // table view frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleNewsTable.frame = view.bounds
    }
    
    // MARK: - Private methods
    // setup table
    private func setupTable() {
        appleNewsTable.delegate = self
        appleNewsTable.dataSource = self
        title = "Apple News"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "title") ??  ""]
    }
    
    // method that calls api to retreive data
    private func fetchData() {
        let date = Date().formatted()
        APICaller.shared.getLatestAppleNews(with: date) { [weak self] result in
            switch result {
            case .success(let articles):
                // hook up articles returned the array of articles
                self?.articles = articles
                ProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self?.appleNewsTable.reloadData()
                }
            case .failure(let error):
                ProgressHUD.show()
                print(error.localizedDescription)
            }
        }
        
    }
}

 // MARK: - Table view extension
    extension TrendingApplesNewsViewController: UITableViewDelegate, UITableViewDataSource {
        // number of articles returned
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return articles.count
        }
        // data to be displayed in cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else { return UITableViewCell()}
            guard let titleNews = articles[indexPath.row].title else { return UITableViewCell() }
            guard let publishedAt = articles[indexPath.row].publishedAt else { return UITableViewCell() }
            let imageNews = URL(string: articles[indexPath.row].urlToImage ?? "")
            cell.configure(viewModel: TopNewsViewCellViewModel(title: titleNews,
                                                               source: articles[indexPath.row].source.name,
                                                               imageUrl: imageNews,
                                                               date: publishedAt))
            return cell
        }
        // row height
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        // navigate to safari browser
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            // get article url
            guard let article = articles[indexPath.row].url else { return }
            // url string
            guard let articleUrl = URL(string: article) else { return }
            // open safari browser
            let vc = SFSafariViewController(url: articleUrl)
            present(vc, animated: true)
        }
    }


