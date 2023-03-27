//
//  HomeViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit
import SafariServices

class TopNewsViewController: UIViewController {
    
    // object of article model
    private var articles: [Article] = [Article]()
    
    // dynamic title date
    let header = Date().formatted(.dateTime.month(.wide).day())
    
    
    
    // MARK: UI Elements
    // top news table
    private let topNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News, \(header)"
    
        view.backgroundColor = .systemBackground
        
        view.addSubview(topNewsTable)
        
        tableSetup()
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topNewsTable.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func tableSetup() {
        topNewsTable.dataSource = self
        topNewsTable.delegate = self
    }
    
//    private func fetchData() {
////        var date = DateFormatter()
////        date.dateFormat = "yyyy-MM-dd"
////        let date = Date().formatted(.iso8601)
////        let date = Date().dayBefore.formatted(.dateTime
////            .year().day().month(.twoDigits))
////        let date = Date().dayBefore.formatted()
//        let date = Date().formatted()
//        APICaller.shared.getTopCanadianNews(with: date) { [weak self] result in
//            switch result {
//            case .success(let articles):
//                self?.articles = articles
//                DispatchQueue.main.async {
//                    self?.topNewsTable.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
//        APICaller.shared.getTopCanadianNews { [weak self] result in
//            switch result {
//            case .success(let articles):
//                self?.articles = articles
//                DispatchQueue.main.async {
//                    self?.topNewsTable.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    private func fetchData() {
        APICaller.shared.getTopCanadianNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.topNewsTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension TopNewsViewController: UITableViewDelegate, UITableViewDataSource {
    // data source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    // delegate function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else { return UITableViewCell()}
        guard let titleNews = articles[indexPath.row].title else { return UITableViewCell() }
//        guard let descriptionNews = articles[indexPath.row].description else { return  UITableViewCell()}
        let imageNews = URL(string: articles[indexPath.row].urlToImage ?? "")
        cell.configure(viewModel: TopNewsViewCellViewModel(title: titleNews,
                                                           source: articles[indexPath.row].source.name,
//                                                           description: descriptionNews,
                                                           imageUrl: imageNews))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = articles[indexPath.row]
        guard let articleUrl = URL(string: url.url ?? "") else {return}
        let vc = SFSafariViewController(url: articleUrl)
        present(vc, animated: true)
                
    }
}
