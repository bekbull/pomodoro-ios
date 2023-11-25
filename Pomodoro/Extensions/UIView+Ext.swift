//
//  UIView+Ext.swift
//  Pomodoro
//
//  Created by Yerassyl Tynymbay on 23.11.2023.
//

import Foundation
import UIKit

extension UIView {
    func pin(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false 
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

