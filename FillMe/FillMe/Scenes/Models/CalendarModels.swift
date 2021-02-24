//
//  User.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/31.
//

import Foundation

struct MonthMetadata {
    let numberOfDays: Int
    let firstDay: Date
    let firstDayWeekday: Int
}

struct Day {
    let date: Date // represents a given day in a month
    let number: String // display on the collection view cell
    let isSelected: Bool // keeps track of whether this date is selected
    let isWithinDisplayedMonth: Bool // tracks if this date is within the currently viewed month
}
