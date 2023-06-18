//
//  TimeConverter.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import Foundation

struct TimeConverter {
    // swiftlint:disable:next large_tuple
    static func secondsToHoursMinutes(seconds: Int) -> (hour: Int, minute: Int, second: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return (hours, minutes, seconds)
    }

    static func hoursMinutesToSeconds(hours: Int, minutes: Int, seconds: Int) -> Int {
        return (hours * 3600) + (minutes * 60) + seconds
    }
}
