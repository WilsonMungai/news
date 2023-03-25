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
        let topNewsVC = TopNewsViewController()
        let appleNewsVC = TrendingApplesNewsViewController()
        let searchVC = SearchViewController()
        
        // Set large titles
        topNewsVC.navigationItem.largeTitleDisplayMode = .automatic
        appleNewsVC.navigationItem.largeTitleDisplayMode = .automatic
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // embed views into a navigation controller
        let topNewsNav = UINavigationController(rootViewController: topNewsVC)
        let appleNewsNav = UINavigationController(rootViewController: appleNewsVC)
        let searchNewsNav = UINavigationController(rootViewController: searchVC)
        
        // set title and tab bar icons
        // top news
        topNewsNav.tabBarItem = UITabBarItem(title: "Top News",
                                             image: UIImage(systemName: "newspaper"),
                                             selectedImage: UIImage(systemName: "newspaper.fill"))
        // apple news
        appleNewsNav.tabBarItem = UITabBarItem(title: "Apple News",
                                               image: UIImage(systemName: "airtag"),
                                               selectedImage: UIImage(systemName: "airtag.fill"))
        // search
        searchNewsNav.tabBarItem = UITabBarItem(title: "Search",
                                                image: UIImage(systemName: "magnifyingglass.circle"),
                                                selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        // display large titles
        for nav in [topNewsNav, appleNewsNav, searchNewsNav] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        // attach view controller to tabs
        setViewControllers([topNewsNav, appleNewsNav, searchNewsNav], animated: true)
        
        // change tint color
        tabBar.tintColor = .label
    }


}

