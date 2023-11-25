//
//  Tag.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 24.11.2023.
//

import Foundation

final class Tag {
    
    var title: String
    var selected: Bool
    var index: Int
    
    init(title: String, selected: Bool, index: Int) {
        self.title = title
        self.selected = selected
        self.index = index
    }
    
}

extension Tag: Hashable {
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.title == rhs.title && lhs.selected == rhs.selected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(selected)
    }
    
}

extension Tag: BYBSettingsDataProtocol {
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

enum SectionTags: BYBSettingsSectionProtocol, CaseIterable {
    var datas: [any BYBSettingsDataProtocol & Hashable] {
        set {}
        get {
            Tags.allTags
        }
    }
    
    case main
    
    var title: String {
        "Focus category"
    }
}

class Tags {
    
    static let work = Tag(title: "Work", selected: false, index: 0)
    static let workout = Tag(title: "Workout", selected: false, index: 1)
    static let reading = Tag(title: "Reading", selected: false, index: 2)
    static let study = Tag(title: "Study", selected: false, index: 3)
    static let meditation = Tag(title: "Meditation", selected: false, index: 4)
    static let other = Tag(title: "Other", selected: true, index: 5)
    
    static var allTags: [Tag] {
            return [work, workout, reading, study, meditation, other]
    }
    
    var title: String {
        let tag = Tags.allTags.filter { tag in
            return tag.selected
        }[0]
        
        return tag.title
    }
}

//extension Tags: Hashable {
//    static func == (lhs: Tags, rhs: Tags) -> Bool {
//        lhs.hashValue == rhs.hashValue
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(hashValue)
//    }
//}
