//
//  UIHelper.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 24.11.2023.
//

import UIKit

enum UIHelper {
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 24
        let minimusItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimusItemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 60)
        
//        flowLayout.minimumInteritemSpacing =  
        flowLayout.minimumLineSpacing = 20
        
        return flowLayout
    }
    
}
