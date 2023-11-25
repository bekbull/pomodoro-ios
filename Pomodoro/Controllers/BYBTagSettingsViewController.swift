//
//  BYBTagSettingsViewController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 24.11.2023.
//

import UIKit

protocol TagDelegate: AnyObject {
    func didTagSelected(with tag: BYBSettingsDataProtocol)
    func didFocusTimeSelected(with tag: BYBSettingsDataProtocol)
    func didBreakTimeSelected(with tag: BYBSettingsDataProtocol)
}


final class BYBTagSettingsViewController: UIViewController {
    
    var type: SettingsType!
    
    private var sections: [BYBSettingsSectionProtocol] {
        set { }
        get {
            if case .category(let sectionTags) = type {
                return sectionTags
            } else if case .time(let sectionTime) = type { return sectionTime }
            return []
        }
    }
    
    weak var delegate: TagDelegate?
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        collectionView.register(BYBHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewIdentifier")
        title = sections[0].title
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BYBSettingsCollectionCell.self, forCellWithReuseIdentifier: BYBSettingsCollectionCell.reuseID)
    }
}

extension BYBTagSettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BYBSettingsCollectionCell.reuseID, for: indexPath) as! BYBSettingsCollectionCell
        cell.set(with: sections[indexPath.section].datas[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewIdentifier", for: indexPath) as? BYBHeaderCollectionView else {
                fatalError("Unable to dequeue MyHeaderView")
            }
            
            // Customize the header view based on section or other factors
            if sections[0].title == "Timer" {
                if indexPath.section == 0 {
                    headerView.titleLabel.text = "Focus Time"
                } else {
                    headerView.titleLabel.text = "Break Time"
                }
            } else {
                headerView.titleLabel.text = nil
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    private func updateTagsSelection(at indexPath: IndexPath) {
        for i in 0..<sections[indexPath.section].datas.count {
            sections[indexPath.section].datas[i].isSelected = indexPath.row == i ? indexPath.row : -1
        }
        
//        sections[indexPath.section].datas[indexPath.row].isSelected = indexPath.row
        collectionView.reloadData()
        
        let data = sections[indexPath.section].datas[indexPath.row]
        if sections[0].title != "Timer" {
            delegate?.didTagSelected(with: data)
        } else {
            if indexPath.section == 0 {
                let focusTime = sections[0].datas[indexPath.row]
                delegate?.didFocusTimeSelected(with: focusTime)
            } else {
                let breakTime = sections[1].datas[indexPath.row]
                delegate?.didBreakTimeSelected(with: breakTime)
            }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateTagsSelection(at: indexPath)
    }
}

extension BYBTagSettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
}

