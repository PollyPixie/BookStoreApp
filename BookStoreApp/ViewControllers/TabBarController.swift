//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 13.01.25.
//

import UIKit

enum TabBarItem {
    case collectionVC
    case multipleSectionsVC
    
    var title: String {
        switch self {
        case .collectionVC: return "Home"
        case .multipleSectionsVC: return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .collectionVC: return UIImage(systemName: "house.fill")
        case .multipleSectionsVC: return UIImage(systemName: "magnifyingglass")
        }
    }
    
    static let allTabBarItems = [collectionVC, multipleSectionsVC]
}

final class TabBarController: UITabBarController {
    private let dataSource: [TabBarItem] = [.collectionVC, .multipleSectionsVC]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarController {
    func setupTabBar() {
        let controllers: [UINavigationController] = TabBarItem.allTabBarItems.map { item in
            getTabBarController(item)
        }
        setViewControllers(controllers, animated: true)
    }
    
    private func getTabBarController(_ item: TabBarItem) -> UINavigationController {
        let navController = UINavigationController()
        navigationController?.navigationBar.tintColor = .white //это чтоооо делает 
        navController.navigationBar.prefersLargeTitles = false// было true надо разобраться
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        navController.tabBarItem.title = item.title
        navController.tabBarItem.image = item.icon
        
        return navController
    }
}
