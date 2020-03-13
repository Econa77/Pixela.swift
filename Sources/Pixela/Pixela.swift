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
        let request = PixelaAPI.UpdateUserRequest(configuration: configuration, newToken: newToken, thanksCode: thanksCode)
        apiClient.send(request, completion: completion)
    }

    func deleteUser(completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteUserRequest(configuration: configuration)
        apiClient.send(request, completion: completion)
    }
}

// MARK: - Channels Request
public extension Pixela {
    func createChannel(id: String, name: String, type: ChannelType, completion: @escaping ((Result<Channel, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.CreateChannelRequest(configuration: configuration, id: id, name: name, type: type)
        apiClient.send(request, completion: completion)
    }

    func getChannels(completion: @escaping ((Result<[Channel], PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetChannelsRequest(configuration: configuration)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.channels))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func updateChannel(id: String, name: String?, type: ChannelType?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdateChannelRequest(configuration: configuration, id: id, name: name, type: type)
        apiClient.send(request, completion: completion)
    }

    func deleteChannel(id: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteChannelRequest(configuration: configuration, id: id)
        apiClient.send(request, completion: completion)
    }
}
