//
//  Time.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import Foundation

final class FocusTime {
    
    var title: String
    var selected: Bool
    var index: Int
    
    init(title: String, selected: Bool, index: Int) {
        self.title = title
        self.selected = selected
        self.index = index
    }
    
}

extension FocusTime: Hashable {
    
    static func == (lhs: FocusTime, rhs: FocusTime) -> Bool {
        lhs.title == rhs.title && lhs.selected == rhs.selected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(selected)
    }
    
}

extension FocusTime: BYBSettingsDataProtocol {
    var isSelected: Int {
        get {
            if self.selected { return self.index }
            return -1
        }
        set {
            self.selected = newValue == self.index
        }
    }
}

class FocusTimes {
    static let _10 = FocusTime(title: "10 minutes", selected: true, index: 0)
    static let _30 = FocusTime(title: "30 minutes", selected: false, index: 1)
    static let _45 = FocusTime(title: "45 minutes", selected: false, index: 2)
    static let _60 = FocusTime(title: "60 minutes", selected: false, index: 3)
    static let _90 = FocusTime(title: "90 minutes", selected: false, index: 4)
    static let _180 = FocusTime(title: "180 minutes", selected: false, index: 5)
    
    static var allTimes: [FocusTime] {
            return [_10, _30, _45, _60, _90, _180]
    }
    
    var title: String {
        let time = FocusTimes.allTimes.filter { time in
            return time.selected
        }[0]
        
        return time.title
    }
}

enum SectionTime: BYBSettingsSectionProtocol, CaseIterable {
    var datas: [any BYBSettingsDataProtocol & Hashable] {
        set {}
        get {
            switch self {
            case .main:
                FocusTimes.allTimes
            case .bbreak:
                BreakTimes.allBreakTimes
            }
        }
    }
    
    case main
    case bbreak
    
    var title: String {
        "Timer"
    }
}

