//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 13.01.25.
//

import UIKit

enum TabBarItem {
    case сollectionViewController
    case multipleSectionsViewController
    
    
    var title: String {
        switch self {
        case .сollectionViewController: return "Home"
        case .multipleSectionsViewController: return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .сollectionViewController: return UIImage(systemName: "house.fill")
        case .multipleSectionsViewController: return UIImage(systemName: "magnifyingglass")
        }
    }
}

class TabBarController: UITabBarController {
    private let dataSource: [TabBarItem] = [.сollectionViewController, .multipleSectionsViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabBarComponents()
        setupTabBar()
    }
}

//MARK: - Settings View
private extension TabBarController {
    private func buildTabBarComponents() {
        viewControllers = dataSource.map {
            switch $0 {
            case .сollectionViewController:
                let collectionViewController = CollectionViewController()
                collectionViewController.bookManager = BookTypeManager()
                return UINavigationController(rootViewController: collectionViewController)
            case .multipleSectionsViewController:
                return UINavigationController(rootViewController: MultipleSectionsViewController())
            }
        }
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers?.enumerated().forEach { index, viewController in
            viewController.tabBarItem.title = dataSource[index].title
            viewController.tabBarItem.image = dataSource[index].icon
        }
    }
}
