//
//  Pixela.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/01/09.
//

import APIKit

public final class Pixela {

    // MARK: - Properties
    private let username: String
    private let token: String
    private let session: APIKit.Session

    // MARK: - Initialize
    public init(username: String, token: String, session: APIKit.Session = .shared) {
        self.username = username
        self.token = token
        self.session = session
    }

}
