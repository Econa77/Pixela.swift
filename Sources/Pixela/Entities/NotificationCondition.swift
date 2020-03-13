//
//  NotificationCondition.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public enum NotificationCondition: String, CustomStringConvertible, Decodable {
    case greaterThan = ">"
    case equal = "="
    case lessThan = "<"
    case multipleOf

    // MARK: - CustomStringConvertible
    public var description: String {
        return rawValue
    }
}
