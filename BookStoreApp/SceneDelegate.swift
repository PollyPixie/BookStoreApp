//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Полина Соколова on 22.12.24.
//

import UIKit

enum Scene {
    case collection
    case multipleSections
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: assembly(scene: .collection))
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func assembly(scene: Scene) -> UIViewController {
        switch scene {
        case .collection:
            let collectionViewController = CollectionViewController()
            collectionViewController.bookManager = BookTypeManager()
            return collectionViewController
        case .multipleSections:
            return MultipleSectionsViewController()
        }
    }
}
