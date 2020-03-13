//
//  Pixel.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public struct Pixel: Decodable {

    // MARK: - Properties
    public let quantity: String
    public let optionalData: Pixel.OptionalData?

}

extension Pixel {
    public struct OptionalData: Decodable {

        // MARK: - Properties
        public let items: [String: Any]

        // MARK: - Initialize
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: AnyCodingKeys.self)
            items = try container.decode([String: Any].self)
        }

        init?(items: [String: Any]?) {
            guard let items = items else { return nil }
            self.items = items
        }

    }
}
