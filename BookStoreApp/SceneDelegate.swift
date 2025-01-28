//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 22.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let allTabBarItems = TabBarItem.allTabBarItems
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = TabBarController()
        
        tabBarController.viewControllers?.enumerated().forEach{
            index, vc in
                guard let navVC = vc as? UINavigationController else { return}
                pushViewController(index: index, controller: navVC)
        }
        
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func pushViewController(index: Int, controller: UINavigationController) {
        
        let bookManager = BookTypeManager() 
        
        switch allTabBarItems[index] {
        case .collectionVC:
            let collectionVC = CollectionViewController(bookTypeManager: bookManager)
            collectionVC.title = TabBarItem.collectionVC.title
            controller.pushViewController(collectionVC, animated: false)
        case .multipleSectionsVC:
            let multipleSectionsVC = MultipleSectionsViewController()
            multipleSectionsVC.title = TabBarItem.multipleSectionsVC.title
            controller.pushViewController(multipleSectionsVC, animated: false)
        }
    }
}
