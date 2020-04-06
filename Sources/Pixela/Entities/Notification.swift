//
//  Notification.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/14.
//

import Foundation

public struct Notification: Decodable {

    // MARK: - Properties
    public let id: String
    public let name: String
    public let target: Notification.Target
    public let condition: Notification.Condition
    public let threshold: String
    public let remindBy: String?
    public let channelID: String

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case target
        case condition
        case threshold
        case remindBy
        case channelID
    }

    // MARK: - Initialize
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.target = try container.decode(Notification.Target.self, forKey: .target)
        self.condition = try container.decode(Notification.Condition.self, forKey: .condition)
        self.threshold = try container.decode(String.self, forKey: .threshold)
        if let remindBy = try container.decodeIfPresent(String.self, forKey: .remindBy), !remindBy.isEmpty {
            self.remindBy = remindBy
        } else {
            self.remindBy = nil
        }
        self.channelID = try container.decode(String.self, forKey: .channelID)
    }

    init(id: String, name: String, target: Notification.Target, condition: Notification.Condition, threshold: String, remindBy: String?, channelID: String) {
        self.id = id
        self.name = name
        self.target = target
        self.condition = condition
        self.threshold = threshold
        self.remindBy = remindBy
        self.channelID = channelID
    }

}

public extension Notification {
    enum Target: String, Decodable {
        case quantity
    }
}

public extension Notification {
    enum Condition: String, CustomStringConvertible, Decodable {
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
