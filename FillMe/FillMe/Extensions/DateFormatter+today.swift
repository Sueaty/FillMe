//
//  DateFormatter+today.swift
//  FillMe
//
//  Created by Sue Cho on 2021/02/17.
//

import Foundation

extension DateFormatter {
    
    var today: String {
        self.dateFormat = "YY-MM-dd"
        return self.string(from: Date())
    }
    
}
