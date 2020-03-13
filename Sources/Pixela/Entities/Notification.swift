
//
//  Notification.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public struct Notification: Decodable {

    // MARK: - Properties
    public let id: String
    public let name: String
    public let target: Notification.Target
    public let condition: Notification.Condition
    public let threshold: String
    public let channelID: String

    // MARK: - Initialize
    init(id: String, name: String, target: Notification.Target, condition: Notification.Condition, threshold: String, channelID: String) {
        self.id = id
        self.name = name
        self.target = target
        self.condition = condition
        self.threshold = threshold
        self.channelID = channelID
    }

}

extension Notification {
    public enum Target: String, Decodable {
        case quantity
    }
}

extension Notification {
    public enum Condition: String, CustomStringConvertible, Decodable {
        case greaterThan = ">"
        case equal = "="
        case lessThan = "<"
        case multipleOf

        // MARK: - CustomStringConvertible
        public var description: String {
            return rawValue
        }
    }
}
