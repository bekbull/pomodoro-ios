//
//  BYBHeaderCollectionView.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import UIKit
import SnapKit

class BYBHeaderCollectionView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(25)
        }
    }
}

