//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by Prudhvi Gadiraju on 4/8/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    fileprivate func setupTabs() {
        viewControllers = [
            createNavController(viewController: SearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            createNavController(viewController: ViewController(), title: "Today", image: #imageLiteral(resourceName: "today_icon")),
            createNavController(viewController: ViewController(), title: "App", image: #imageLiteral(resourceName: "apps"))
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        // Set Title
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        // Create Nav Controller
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        // Return
        return navigationController
    }
}
