//
//  Settings.swift
//  Pomodoro
//
//  Created by Bekbol Bolatov on 25.11.2023.
//

import Foundation

enum SettingsType {
    case time([SectionTime])
    case category([SectionTags])
}

protocol BYBSettingsSectionProtocol {
    var title: String { get }
    var datas: [any BYBSettingsDataProtocol & Hashable] { set get }
}

protocol BYBSettingsDataProtocol {
    var title: String { get }
    var isSelected: Int { set get }
}
