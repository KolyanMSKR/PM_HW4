//
//  SceneDelegate.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window?.makeKeyAndVisible()
        
        let navController = UINavigationController(rootViewController: CityViewController())
        navController.navigationBar.barTintColor = .black
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.modalPresentationStyle = .fullScreen
        
        window?.rootViewController = navController
    }

}

