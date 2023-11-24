//
//  BYBTabBarController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit
import SwiftUI

class BYBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .white
        
        self.setUpTabs()
    }
    

    
    private func setUpTabs(){
        let main = createNav(with: "Main", and: BYBImages.house, vc: BYBMainViewController()) //Comment Just for fun (check) try vc: UIHostingController(rootview:TestView())
        let todos = createNav(with: "Todos", and: BYBImages.checklist, vc: BYBTodosViewController())
        let history = createNav(with: "History", and: BYBImages.listClipboard, vc: BYBHistoryViewController())
        self.setViewControllers([main,todos,history], animated: true)
    }
    
    private func createNav (with title : String, and image : UIImage? , vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
