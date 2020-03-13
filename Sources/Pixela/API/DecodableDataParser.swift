//
//  DecodableDataParser.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {

    // MARK: - DataParser
    var contentType: String? {
        return "application/json"
    }

    public func parse(data: Data) throws -> Any {
        return data
    }

}
