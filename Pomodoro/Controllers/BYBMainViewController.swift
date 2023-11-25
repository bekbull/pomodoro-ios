//
//  BYBMainViewController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 22.11.2023.
//

import UIKit
import SnapKit

class BYBMainViewController: UIViewController {
    
    private let tagButton = BYBCapsuleButton(backgroundColor: .systemBlue, title: "Work")
    private let startButton = BYBCapsuleButton(backgroundColor: .systemBlue, title: "Start")
    private let timerVC = BYBTimerViewController()
    private var circularView = BYBCircularProgressView()
    private var duration: TimeInterval!
    private var breakDuration: Int!
    private var timerTicking = false
    private var cnt = 0

    var configuration = UIButton.Configuration.plain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addChild(timerVC)
        view.addSubview(timerVC.view)
        timerVC.didMove(toParent: self)

        
        configureLayout()
        configureActions()
    }
    
    private func configureLayout() {
        view.addSubviews(tagButton, circularView, startButton)
        
        tagButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(140)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        circularView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        timerVC.view.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
        
    }
    
    private func configureActions() {
        tagButton.addTarget(self, action: #selector(tagButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeButtonTapped))
        
        timerVC.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func startButtonTapped() {
        if !timerTicking {
            duration = TimeInterval(timerVC.secondsRemaining)
            if cnt > 0 {
                circularView.resumeLayer(layer: circularView.progressLayer)
            } else {
                circularView.startProgressAnimation(duration: duration)
            }
            timerVC.startTimer()
            startButton.setTitle("Pause", for: .normal)
        } else {
            timerVC.stopTimer()
            circularView.pauseLayer(layer: circularView.progressLayer)
            cnt += 1
            startButton.setTitle("Start/Resume", for: .normal)
        }
        timerTicking = !timerTicking
    }
    
    @objc private func tagButtonTapped() {
        
        let vc = BYBTagSettingsViewController()
        vc.type = .category(SectionTags.allCases)
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func timeButtonTapped() {
        
        let vc = BYBTagSettingsViewController()
        vc.type = .time(SectionTime.allCases)
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(nav, animated: true, completion: nil)
    }
    
}

extension BYBMainViewController: TagDelegate {
    func didFocusTimeSelected(with tag: BYBSettingsDataProtocol) {
        let seconds = Int(tag.title.split(separator: " ")[0])! * 60
        timerVC.stopTimer()
        circularView.rmAnimation()
        
        timerVC.secondsRemaining = seconds
        timerVC.updateUI()
        cnt = 0
        timerTicking = false
    }
    
    func didBreakTimeSelected(with tag: BYBSettingsDataProtocol) {
        breakDuration = Int(tag.title.split(separator: " ")[0])! * 60
    }
    
    func didTagSelected(with tag: BYBSettingsDataProtocol) {
        tagButton.setTitle(tag.title, for: .normal)
    }
}
