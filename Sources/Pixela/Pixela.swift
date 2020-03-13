//
//  Pixela.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/01/09.
//

import Foundation
import APIKit

public final class Pixela {

    // MARK: - Properties
    public static var shared: Pixela = {
        return Pixela(configuration: nil)
    }()

    public var configuration: Configuration?
    private let apiClient: APIClient

    // MARK: - Initialize
    public convenience init(configuration: Configuration?) {
        self.init(configuration: configuration, session: .shared)
    }

    init(configuration: Configuration?, session: APIKit.Session) {
        self.configuration = configuration
        self.apiClient = APIClient(session: session)
    }

    private func fetchConfiguration() -> Configuration {
        guard let configuration = self.configuration else {
            fatalError("[Pixela.swift] Must set the Pixela.shared.configuration before use.")
        }
        return configuration
    }

}

// MARK: - Users Request
public extension Pixela {
    func createUser(token: String, username: String, isAgreeTermsOfService: Bool, isNotMinor: Bool, thanksCode: String?, completion: @escaping ((Result<Configuration, PixelaError>) -> Void)) {
        let request = PixelaAPI.CreateUserRequest(token: token, username: username, isAgreeTermsOfService: isAgreeTermsOfService, isNotMinor: isNotMinor, thanksCode: thanksCode)
        apiClient.send(request, completion: completion)
    }

    func updateUser(newToken: String, thanksCode: String?, completion: @escaping ((Result<Configuration, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdateUserRequest(token: configuration.token, username: configuration.username, newToken: newToken, thanksCode: thanksCode)
        apiClient.send(request, completion: completion)
    }

    func deleteUser(completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteUserRequest(token: configuration.token, username: configuration.username)
        apiClient.send(request, completion: completion)
    }
}
