//
//  BYBSettingsCollectionCell.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 24.11.2023.
//

import UIKit
import SnapKit

final class BYBSettingsCollectionCell: UICollectionViewCell {
    static let reuseID = "BYBSettingsCollectionCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        layer.cornerRadius = 16
        layer.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1).cgColor
        
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1).cgColor
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            layer.backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.2, alpha: 1).cgColor
            label.textColor = .white
        } else {
            layer.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1).cgColor
            label.textColor = .black
        }
    }
    
    func set(with data: BYBSettingsDataProtocol) {
        label.text = data.title
        setSelected(data.isSelected != -1)
    }
    
}
