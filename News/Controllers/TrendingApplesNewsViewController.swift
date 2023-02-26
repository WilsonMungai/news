//
//  TrendingApplesNewsViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-26.
//

import UIKit

class TrendingApplesNewsViewController: UIViewController {
    
    let appleNewsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Apple Articles"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground

    }

}


