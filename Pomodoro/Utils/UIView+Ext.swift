//
//  UIView+Ext.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
