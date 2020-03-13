
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
    public let target: NotificationTarget
    public let condition: NotificationCondition
    public let threshold: String
    public let channelID: String

    // MARK: - Initialize
    init(id: String, name: String, target: NotificationTarget, condition: NotificationCondition, threshold: String, channelID: String) {
        self.id = id
        self.name = name
        self.target = target
        self.condition = condition
        self.threshold = threshold
        self.channelID = channelID
    }
}
