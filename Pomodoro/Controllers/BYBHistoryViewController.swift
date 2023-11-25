//
//  BYBHistoryViewController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit
import SwiftUI
enum FocusType: String {
    case focusTime = "Focus time"
    case breakTime = "Break time"
    case session = "Session"

    
    var time: String {
        switch self {
        case .focusTime:
            return "25:00"
        case .breakTime:
            return "5:00"
        case .session:
            return "2"
        }
    }
}

struct Focus {
    let type: FocusType
}
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

class BYBHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let headers = ["21.11.21", "20.11.21", "19.11.21"]

    let data: [[Focus]] = [
           [Focus(type: .focusTime), Focus(type: .breakTime), Focus(type: .session)],
           [Focus(type: .focusTime), Focus(type: .breakTime), Focus(type: .session)],
           [Focus(type: .focusTime), Focus(type: .breakTime), Focus(type: .session)]
       ]

            

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MySectionHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.darkGray

       
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return headers.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data[section].count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Set the background color of the cell to black
        cell.backgroundColor = UIColor.white

        let focusItem = data[indexPath.section][indexPath.row]

        // Set the title on the left side with white text color
        cell.textLabel?.text = focusItem.type.rawValue
        cell.textLabel?.textColor = UIColor.black
        // Set the time on the right side with white text color
        let timeLabel = UILabel()
        timeLabel.text = focusItem.type.time
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = UIColor.black

        // Set the background color of the time label to black
        timeLabel.backgroundColor = UIColor.white

        cell.contentView.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            timeLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! MySectionHeader
            header.titleLabel.text = headers[section]
            return header
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40.0
        }
    
}


struct BYBHistoryViewControllerProvider : PreviewProvider {
    static var previews : some View {
        BYBHistoryViewControllerPreview{
            BYBHistoryViewController()
        }.edgesIgnoringSafeArea(.all)
    }
    
}
class MySectionHeader: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    
    var isSectionSelected: Bool = false {
        didSet {
            // Update the background color when the selected state changes
            contentView.backgroundColor = isSectionSelected ? UIColor.white : UIColor.black
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        // Set the initial background color
        contentView.backgroundColor = UIColor.white
    }
}


