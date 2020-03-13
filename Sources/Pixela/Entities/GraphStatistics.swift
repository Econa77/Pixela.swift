//
//  GraphStatistics.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public struct GraphStatistics: Decodable {

    // MARK: - Properties
    let totalPixelsCount: Int
    let maxQuantity: Int
    let minQuantity: Int
    let totalQuantity: Int
    let avgQuantity: Int
    let todaysQuantity: Int

}
