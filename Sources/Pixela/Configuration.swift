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

public struct APIConfiguration {

    // MARK: - Properties
    public let baseURL: URL
    public let userAgent: String

    public static var `default`: APIConfiguration = {
        return APIConfiguration()
    }()

    // MARK: - Initialize
    init(baseURL: URL = URL(string: "https://pixe.la")!, userAgent: String = "Pixela.swift(https://github.com/Econa77/Pixela.swift)") {
        self.baseURL = baseURL
        self.userAgent = userAgent
    }

}
