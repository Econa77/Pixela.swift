//
//  GraphStatistics.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public struct GraphStatistics: Decodable {

    // MARK: - Properties
    public let totalPixelsCount: Int
    public let maxQuantity: Int
    public let minQuantity: Int
    public let totalQuantity: Int
    public let avgQuantity: Int
    public let todaysQuantity: Int

}
