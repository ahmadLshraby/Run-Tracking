//
//  Ext.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation

extension Int {
    func formatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = ( self % 3600 ) / 60
        let durationSeconds = ( self % 3600) % 60
        
        if durationSeconds < 0 {
            return "00.00.00"
        }else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSeconds)
            }else {
                return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
            }
        }
    }
}

extension NSDate {
    // to get day/month/year instead off year/month/day - time - zone
    // call it in the cell
    func getDateString() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self as Date)
        let month = calendar.component(.month, from: self as Date)
        let year = calendar.component(.year, from: self as Date)
        
        return "\(day)/\(month)/\(year)"
    }
}
