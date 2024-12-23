//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 22.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let collectionViewController = CollectionViewController()
        collectionViewController.bookManager = BookTypeManager()
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = collectionViewController
        window?.makeKeyAndVisible()
    }
}
