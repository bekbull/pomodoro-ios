//
//  BreakTime.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import Foundation

final class BreakTime {
    
    var title: String
    var selected: Bool
    var index: Int
    
    init(title: String, selected: Bool, index: Int) {
        self.title = title
        self.selected = selected
        self.index = index
    }
    
}

extension BreakTime: Hashable {
    
    static func == (lhs: BreakTime, rhs: BreakTime) -> Bool {
        lhs.title == rhs.title && lhs.selected == rhs.selected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(selected)
    }
    
}

extension BreakTime: BYBSettingsDataProtocol {
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

class BreakTimes {
    static let _5 = BreakTime(title: "5 minutes", selected: true, index: 0)
    static let _10 = BreakTime(title: "10 minutes", selected: false, index: 1)
    static let _30 = BreakTime(title: "30 minutes", selected: false, index: 2)
    static let _60 = BreakTime(title: "60 minutes", selected: false, index: 3)
    
    static var allBreakTimes: [BreakTime] {
            return [_5, _10, _30, _60]
    }
    
    var title: String {
        let time = BreakTimes.allBreakTimes.filter { time in
            return time.selected
        }[0]
        
        return time.title
    }
}
