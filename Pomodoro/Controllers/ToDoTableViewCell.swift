////
////  ToDoTableViewCell.swift
////  Pomodoro
////
////  Created by Bagdaulet Sundetkaliyev on 25.11.2023.
////
//
//import UIKit
//
//class ToDoTableViewCell: UITableViewCell {
//    var titleLabel: UILabel!
//    var checkMark: UIButton!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setup() {
//        titleLabel = UILabel(frame: contentView.bounds)
//        titleLabel.textAlignment = .left
//        contentView.addSubview(titleLabel)
//
//        checkMark = UIButton(type: .system)  // Initialize the UIButton with a system type
//        checkMark.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(checkMark)
//
//        NSLayoutConstraint.activate([
//            checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            checkMark.widthAnchor.constraint(equalToConstant: 30),
//            checkMark.heightAnchor.constraint(equalToConstant: 30),
//
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: checkMark.leadingAnchor, constant: -10),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//        ])
//
//    }
//}
import UIKit
class ToDoTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var checkMark: UIButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)

        checkMark = UIButton(type: .system)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        //checkMark.isEnabled = false
        contentView.addSubview(checkMark)

        NSLayoutConstraint.activate([
            checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMark.widthAnchor.constraint(equalToConstant: 30),
            checkMark.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: checkMark.leadingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

}

