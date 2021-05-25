//
//  HomeTabbarController.swift
//  TestSimpleAppDOT
//
//  Created by Sayyid Maulana Khakul Yakin on 25/05/21.
//

import UIKit

class HomeTabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetup()
    }
    
    private func tabBarSetup() {
    
        let firstController = UINavigationController(rootViewController: UserViewController())
        firstController.title = "User"

        let secondController = UINavigationController(rootViewController: RepositoryViewController())
        secondController.title = "Repository"

        let thirdController = UINavigationController(rootViewController: IssueViewController())
        thirdController.title = "Issues"
        
        viewControllers = [firstController,secondController,thirdController]
        tabBar.isTranslucent = false
        navigationController?.navigationBar.isTranslucent = false
    }

}
