//
//  Channel.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation

public struct Channel: Decodable {

    // MARK: - Properties
    public let id: String
    public let name: String
    public let type: Channel.ChannelType

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case detail
    }

    // MARK: - Initialize
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let notificationType = try container.decode(Channel.NotificationType.self, forKey: .type)
        switch notificationType {
        case .slack:
            let slack = try container.decode(Channel.ChannelType.Slack.self, forKey: .detail)
            self.type = .slack(slack)
        }
    }

    init(id: String, name: String, type: Channel.ChannelType) {
        self.id = id
        self.name = name
        self.type = type
    }

}

extension Channel {
    enum NotificationType: String, Decodable {
        case slack
    }
}

extension Channel {
    public enum ChannelType {
        case slack(Slack)
    }
}

extension Channel.ChannelType {
    public struct Slack: Decodable {

        // MARK: - Properties
        public let url: String
        public let userName: String
        public let channelName: String

        // MARK: - Initialize
        public init(url: String, userName: String, channelName: String) {
            self.url = url
            self.userName = userName
            self.channelName = channelName
        }

    }
}
