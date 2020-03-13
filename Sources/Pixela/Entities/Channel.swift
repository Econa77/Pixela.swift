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
    public let type: ChannelType

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
        let notificationType = try container.decode(NotificationType.self, forKey: .type)
        switch notificationType {
        case .slack:
            let slack = try container.decode(Slack.self, forKey: .detail)
            self.type = .slack(slack)
        }
    }

    init(id: String, name: String, type: ChannelType) {
        self.id = id
        self.name = name
        self.type = type
    }

}
