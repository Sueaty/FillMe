//
//  DateFormatter+today.swift
//  FillMe
//
//  Created by Sue Cho on 2021/02/17.
//

import Foundation

extension DateFormatter {
    
    var today: String {
        calendar = Calendar(identifier: .gregorian)
        locale = Locale.autoupdatingCurrent
        setLocalizedDateFormatFromTemplate("YY-MM-dd")
        return string(from: Date())
    }
    
    var homeTitle: String {
        calendar = Calendar(identifier: .gregorian)
        locale = Locale.autoupdatingCurrent
        setLocalizedDateFormatFromTemplate("MMMM d")
        return string(from: Date())
    }
    
    func currentCalendarTitle(date: Date) -> String {
        calendar = Calendar(identifier: .gregorian)
        locale = Locale.autoupdatingCurrent
        setLocalizedDateFormatFromTemplate("MMMM y")
        return string(from: date)
    }
    
    func diaryTitleDate(date: Date) -> String {
        calendar = Calendar(identifier: .gregorian)
        locale = Locale.autoupdatingCurrent
        setLocalizedDateFormatFromTemplate("yyyy.MMMM.d")
        return string(from: date)
    }
    
    func generateDayLabel(date: Date) -> String {
        self.dateFormat = "d"
        return self.string(from: date)
    }
    
}
