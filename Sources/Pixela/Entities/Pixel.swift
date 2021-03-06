//
//  Pixel.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/14.
//

import Foundation

public struct Pixel: Decodable {

    // MARK: - Properties
    public let quantity: String
    public let optionalData: String?

    // MARK: - Initialize
    init(quantity: String, optionalData: String?) {
        self.quantity = quantity
        self.optionalData = optionalData
    }

}
