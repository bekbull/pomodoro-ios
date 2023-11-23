//
//  UIView+Ext.swift
//  Pomodoro
//
//  Created by Yerassyl Tynymbay on 23.11.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func pin (to superView : UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
