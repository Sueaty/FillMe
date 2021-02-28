//
//  CalendarManager.swift
//  FillMe
//
//  Created by Sue Cho on 2021/02/24.
//

import Foundation

final class CalendarManager {
    
    enum CalendarDateError: Error {
        case metadataGeneration
        case daysInMonthGeneration
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    private var selectedDate = Date()
    private var baseDate = Date() {
        didSet {
            days = generateDaysInMonth(for: baseDate)
        }
    }
    private lazy var days = generateDaysInMonth(for: baseDate)
    private var numberofWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
}

private extension CalendarManager {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        guard let numberofDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month],
                                                                                from: baseDate)) else {
            throw CalendarDateError.metadataGeneration
        }
        
        let firstDayOfWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        return MonthMetadata(numberOfDays: numberofDaysInMonth,
                             firstDay: firstDayOfMonth,
                             firstDayWeekday: firstDayOfWeekday)
    }
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] { 
        guard let metadata = try? monthMetadata(for: baseDate) else {
            fatalError("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
            let isWithinDisplayedMonth = day >= offsetInInitialRow
            let dayOffset
                = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
            return generateDay(offsetBy: dayOffset,
                               for: firstDayOfMonth,
                               isWithinDisplayedMonth: isWithinDisplayedMonth)
        }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        return days
    }
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        return Day(date: date,
                   number: DateFormatter().dayLabel,
                   isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                   isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                                 to: firstDayOfDisplayedMonth) else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        
        let days: [Day] = (1...additionalDays).map {
            generateDay(offsetBy: $0,
                        for: lastDayInMonth,
                        isWithinDisplayedMonth: false)
        }
        
        return days
    }
}
