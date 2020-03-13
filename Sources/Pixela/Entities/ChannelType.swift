//
//  ChannelType.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation

public enum ChannelType {
    case slack(Slack)
}

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