//
//  Configuration.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/13.
//

import Foundation

public struct Configuration {

    // MARK: - Properties
    public let username: String
    public let token: String

    // MARK: - Initialize
    public init(username: String, token: String) {
        self.username = username
        self.token = token
    }

}
