//
//  MainTab.swift
//  SocailPost
//
//  Created by Mahmoud Sherbeny on 12/05/2021.
//

import UIKit

class MainTab: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [PostVC()]
        let vc0 = navigationController
        vc0.tabBarItem.title = "Post"
        
        vc0.tabBarItem.image = UIImage(systemName: "star.fill")
        self.viewControllers?.insert(vc0, at: 0)
    }

}
