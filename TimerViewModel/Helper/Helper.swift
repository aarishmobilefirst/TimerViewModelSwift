//
//  Helper.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import Foundation

class Helper {
    static func formattedTime(for timeRemaining: TimeInterval) -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        let milliseconds = Int((timeRemaining * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}
