//
//  AppSetting.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct Application: Identifiable {
    var id: String
    var iconImageName: UIImage
    var size: Int
    
    static var fixedPartitioningApps: [Application] {
        [
            Application(id: "keynote", iconImageName: #imageLiteral(resourceName: "Keynote.png"), size: 900),
            Application(id: "safari", iconImageName: #imageLiteral(resourceName: "Safari.png"), size: 325),
            Application(id: "mail", iconImageName: #imageLiteral(resourceName: "Mail.png"), size: 130),
            Application(id: "photos", iconImageName: #imageLiteral(resourceName: "Photos.png"), size: 220),
            Application(id: "calculator", iconImageName: #imageLiteral(resourceName: "Calculator.png"), size: 90)
        ]
    }
    
    static var dynamicPartitioningApps: [Application] {
        [
            Application(id: "pages", iconImageName: #imageLiteral(resourceName: "Pages.png"), size: 565),
            Application(id: "numbers", iconImageName: #imageLiteral(resourceName: "Numbers.png"), size: 470),
            Application(id: "music", iconImageName: #imageLiteral(resourceName: "Music.png"), size: 180),
            Application(id: "facetime", iconImageName: #imageLiteral(resourceName: "FaceTime.png"), size: 110),
            Application(id: "xcode", iconImageName: #imageLiteral(resourceName: "Xcode.png"), size: 2000),
            Application(id: "imovie", iconImageName: #imageLiteral(resourceName: "iMovie.png"), size: 800)
        ]
    }
    
    static var simplePagingApps: [Application] {
        [
            Application(id: "keynote", iconImageName: #imageLiteral(resourceName: "Keynote.png"), size: 900),
            Application(id: "safari", iconImageName: #imageLiteral(resourceName: "Safari.png"), size: 325),
            Application(id: "photos", iconImageName: #imageLiteral(resourceName: "Photos.png"), size: 220),
            Application(id: "calculator", iconImageName: #imageLiteral(resourceName: "Calculator.png"), size: 90),
            Application(id: "pages", iconImageName: #imageLiteral(resourceName: "Pages.png"), size: 565),
            Application(id: "numbers", iconImageName: #imageLiteral(resourceName: "Numbers.png"), size: 470),
            Application(id: "music", iconImageName: #imageLiteral(resourceName: "Music.png"), size: 180),
            Application(id: "xcode", iconImageName: #imageLiteral(resourceName: "Xcode.png"), size: 2000),
            Application(id: "imovie", iconImageName: #imageLiteral(resourceName: "iMovie.png"), size: 800)
        ]
    }
}

struct AppItemPreferenceData: Equatable {
    let appId: String
    let rect: CGRect
}

struct AppItemPreferenceKey: PreferenceKey {
    typealias Value = [AppItemPreferenceData]
    
    static var defaultValue: [AppItemPreferenceData] = []
    
    static func reduce(value: inout [AppItemPreferenceData], nextValue: () -> [AppItemPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
