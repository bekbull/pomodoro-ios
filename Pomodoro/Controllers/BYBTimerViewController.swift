//
//  BYBTimerViewController.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import UIKit

final class BYBTimerViewController: UIViewController {
    
    let countdownLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.text = "01:00"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    var countdownTimer: Timer?
    var secondsRemaining = 60 // Set your desired countdown duration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    deinit {
        stopTimer()
    }
    
    func updateUI() {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        
        countdownLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateUI()
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}
