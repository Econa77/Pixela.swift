//
//  GraphColor.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation

public enum GraphColor: String, CustomStringConvertible, Decodable {
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
