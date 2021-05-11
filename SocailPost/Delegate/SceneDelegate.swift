//
//  SceneDelegate.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 11/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [PostVC()]
        window?.rootViewController = navigationController
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
