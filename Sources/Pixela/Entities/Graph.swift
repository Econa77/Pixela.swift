//
//  Graph.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/13.
//

import Foundation

public struct Graph: Decodable {

    // MARK: - Properties
    public let id: String
    public let name: String
    public let unit: String
    public let type: Graph.GraphType
    public let color: Graph.Color
    public let purgeCacheURLs: [URL]
    public let timeZone: TimeZone?
    public let selfSufficient: Graph.SelfSufficient
    public let isSecret: Bool?
    public let isPublishOptionalData: Bool?

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
        self.type = try container.decode(Graph.GraphType.self, forKey: .type)
        self.color = try container.decode(Graph.Color.self, forKey: .color)
        self.purgeCacheURLs = try container.decodeIfPresent([URL].self, forKey: .purgeCacheURLs) ?? []
        if let timeZoneIdentifier = try container.decodeIfPresent(String.self, forKey: .timeZone) {
            self.timeZone = TimeZone(identifier: timeZoneIdentifier)
        } else {
            self.timeZone = nil
        }
        self.selfSufficient = try container.decode(Graph.SelfSufficient.self, forKey: .selfSufficient)
        self.isSecret = try container.decodeIfPresent(Bool.self, forKey: .isSecret)
        self.isPublishOptionalData = try container.decodeIfPresent(Bool.self, forKey: .isPublishOptionalData)
    }

    init(id: String, name: String, unit: String, type: Graph.GraphType, color: Graph.Color, purgeCacheURLs: [URL], timeZone: TimeZone?, selfSufficient: Graph.SelfSufficient, isSecret: Bool?, isPublishOptionalData: Bool?) {
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

public extension Graph {
    enum GraphType: String, Decodable {
        case int
        case float
    }
}

public extension Graph {
    enum Color: String, CustomStringConvertible, Decodable {
        case green = "shibafu"
        case red = "momiji"
        case blue = "sora"
        case yellow = "ichou"
        case purple = "ajisai"
        case black = "kuro"

        // MARK: - CustomStringConvertible
        public var description: String {
            return rawValue
        }
    }
}

public extension Graph {
    enum SelfSufficient: String, Decodable {
        case increment
        case decrement
        case none
    }
}

public extension Graph {
    enum SVGMode: String {
        case short
        case badge
        case line
    }

    enum HTMLMode: String {
        case simple
        case simpleShort = "simple-short"
    }

}

public extension Graph {
    enum Appearance: String {
        case dark
    }
}

public extension Graph {
    struct Statistics: Decodable {

        // MARK: - Properties
        public let totalPixelsCount: Int
        public let maxQuantity: Int
        public let minQuantity: Int
        public let totalQuantity: Int
        public let avgQuantity: Int
        public let todaysQuantity: Int

    }
}
