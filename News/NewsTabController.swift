//
//  ViewController.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-24.
//

import UIKit

class NewsTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    // setup tab bar
    private func setUpTabs() {
        // initialize controllers
        let topNewsVC = UINavigationController(rootViewController: TopNewsViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        
        
        // Add image
        topNewsVC.tabBarItem.image = UIImage(systemName: "newspaper")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        topNewsVC.title = "Top Stories"
        searchVC.title = "Search"
        
        tabBar.tintColor = .label
        
        setViewControllers([topNewsVC, searchVC], animated: true)
    }


}

