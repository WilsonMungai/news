//
//  HomeViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit

class TopNewsViewController: UIViewController {
    
    private let topNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(topNewsTable)
        
        topNewsTable.dataSource = self
        topNewsTable.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topNewsTable.frame = view.bounds
    }

}

extension TopNewsViewController: UITableViewDelegate, UITableViewDataSource {
    // data source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    // delegate function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier, for: indexPath) as? TopNewsTableViewCell else { return UITableViewCell()}
        cell.backgroundColor = .systemBackground
        return cell
    }
}
