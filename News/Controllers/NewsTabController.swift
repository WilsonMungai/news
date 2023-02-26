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
        let appleNewsVC = UINavigationController(rootViewController: TrendingApplesNewsViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
       
        // Add image
        topNewsVC.tabBarItem.image = UIImage(systemName: "newspaper")
        appleNewsVC.tabBarItem.image = UIImage(systemName: "airtag.fill")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        
        topNewsVC.title = "Top Stories"
        searchVC.title = "Search"
        appleNewsVC.title = "Apple News"
        
        tabBar.tintColor = .label
        
        setViewControllers([topNewsVC, appleNewsVC,searchVC], animated: true)
    }


}

