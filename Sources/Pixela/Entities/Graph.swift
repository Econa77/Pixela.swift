//
//  Graph.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation

public struct Graph: Decodable {

    // MARK: - Properties
    let id: String
    let name: String
    let unit: String
    let type: GraphType
    let color: GraphColor
    let purgeCacheURLs: [URL]
    let timeZone: TimeZone?
    let selfSufficient: GraphSelfSufficient
    let isSecret: Bool?
    let isPublishOptionalData: Bool?

    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case unit
        case type
        case color
        case purgeCacheURLs
        case timeZone = "timezone"
        case selfSufficient
        case isSecret
        case isPublishOptionalData = "publishOptionalData"
    }

    // MARK: - Initialize
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.type = try container.decode(GraphType.self, forKey: .type)
        self.color = try container.decode(GraphColor.self, forKey: .color)
        self.purgeCacheURLs = try container.decodeIfPresent([URL].self, forKey: .purgeCacheURLs) ?? []
        if let timeZoneIdentifier = try container.decodeIfPresent(String.self, forKey: .timeZone) {
            self.timeZone = TimeZone(identifier: timeZoneIdentifier)
        } else {
            self.timeZone = nil
        }
        self.selfSufficient = try container.decode(GraphSelfSufficient.self, forKey: .selfSufficient)
        self.isSecret = try container.decodeIfPresent(Bool.self, forKey: .isSecret)
        self.isPublishOptionalData = try container.decodeIfPresent(Bool.self, forKey: .isPublishOptionalData)
    }

    init(id: String, name: String, unit: String, type: GraphType, color: GraphColor, purgeCacheURLs: [URL], timeZone: TimeZone?, selfSufficient: GraphSelfSufficient, isSecret: Bool?, isPublishOptionalData: Bool?) {
        self.id = id
        self.name = name
        self.unit = unit
        self.type = type
        self.color = color
        self.purgeCacheURLs = purgeCacheURLs
        self.timeZone = timeZone
        self.selfSufficient = selfSufficient
        self.isSecret = isSecret
        self.isPublishOptionalData = isPublishOptionalData
    }

}
