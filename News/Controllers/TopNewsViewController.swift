//
//  HomeViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit

class TopNewsViewController: UIViewController {
    
    private var articles: [Article] = [Article]()
    
    private let topNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        view.backgroundColor = .systemBackground
        
        view.addSubview(topNewsTable)
        
        topNewsTable.dataSource = self
        topNewsTable.delegate = self
        
        fetchData()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topNewsTable.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchData() {
        APICaller.shared.getTopCanadianNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.topNewsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
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
        guard let descriptionNews = articles[indexPath.row].description else { return  UITableViewCell()}
        let imageNews = URL(string: articles[indexPath.row].urlToImage ?? "")
        cell.configure(viewModel: TopNewsViewCellViewModel(title: titleNews,
                                                           description: descriptionNews,
                                                           imageUrl: imageNews))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
