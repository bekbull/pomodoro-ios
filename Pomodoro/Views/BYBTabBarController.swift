//
//  BYBTabBarController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit

class BYBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = .system
        
        viewControllers = [
            createMainNavigationController(),
            createTodosNavigationController(),
            createHistoryNavigationController()
        ]
    }
    
    private func createMainNavigationController() -> UINavigationController {
        let vc = BYBMainViewController()
        vc.tabBarItem = UITabBarItem(title: "Main", image: BYBImages.house, tag: 0)

        return UINavigationController(rootViewController: vc)
    }
    
    private func createTodosNavigationController() -> UINavigationController {
        let vc = BYBTodosViewController()
        vc.tabBarItem = UITabBarItem(title: "Todos", image: BYBImages.checklist, tag: 1)

        return UINavigationController(rootViewController: vc)
    }
    
    private func createHistoryNavigationController() -> UINavigationController {
        let vc = BYBHistoryViewController()
        vc.tabBarItem = UITabBarItem(title: "History", image: BYBImages.listClipboard, tag: 2)

        return UINavigationController(rootViewController: vc)
    }
    
}
