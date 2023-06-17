//
//  TimerPickerMode.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import Foundation

enum TimerPickerMode {
    case totalTime
    case first
    case second
    case third
    var title: String {
        switch self {
        case .totalTime:
            return "プレゼン時間"
        case .first:
            return "ベルが一回鳴る時間"
        case .second:
            return "ベルが二回鳴る時間"
        case .third:
            return "ベルが三回鳴る時間"
        }
    }
    }
