//
//  BYBHistoryViewController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit
import SwiftUI
struct BYBHistoryViewControllerPreview : UIViewControllerRepresentable {
    
    let viewControllerGenerator : () -> UIViewController
    init(viewControllerGenerator: @escaping () -> UIViewController) {
        self.viewControllerGenerator = viewControllerGenerator
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerGenerator()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
}

class BYBHistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
    
}
struct BYBHistoryViewControllerProvider : PreviewProvider {
    static var previews : some View {
        BYBMainViewControllerPreview{
            BYBMainViewController()
        }.edgesIgnoringSafeArea(.all)
    }
    
}


