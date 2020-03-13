//
//  DateExtension.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

extension Date {
    func formatString(format: String = "yyyyMMdd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
