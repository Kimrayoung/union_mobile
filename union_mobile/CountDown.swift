//
//  CountDown.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import Foundation

private enum TimeComponent {
    static let secondsInDay: Int = 24 * 60 * 60
    static let secondsInHour: Int = 60 * 60
    static let secondsInMinute: Int = 60
}

struct CountDownTimeComponent {
    let totalSeconds: TimeInterval
    
    var days: Int { Int(totalSeconds) / TimeComponent.secondsInDay }
    var hours: Int { (Int(totalSeconds) % TimeComponent.secondsInDay) / TimeComponent.secondsInHour }
    var minutes: Int { (Int(totalSeconds) % TimeComponent.secondsInHour) / TimeComponent.secondsInMinute }
    var seconds: Int { Int(totalSeconds) % TimeComponent.secondsInMinute }
    
    var isValid: Bool { totalSeconds >= 0 }
}
