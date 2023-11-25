//
//  BYBCapsuleButton.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit

class BYBCapsuleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = bounds.height
        layer.cornerRadius = height/2
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
//        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        var config = UIButton.Configuration.tinted()
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .capsule
        
        configuration = config
        
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
}
