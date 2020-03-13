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
    public init(configuration: Configuration?, session: APIKit.Session = .shared) {
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

// MARK: - Graphs Request
public extension Pixela {
    func createGraph(id: String, name: String, unit: String, type: GraphType, color: GraphColor, timeZone: TimeZone?, selfSufficient: GraphSelfSufficient?, isSecret: Bool?, isPublishOptionalData: Bool?, completion: @escaping ((Result<Graph, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.CreateGraphRequest(configuration: configuration, id: id, name: name, unit: unit, type: type, color: color, timeZone: timeZone, selfSufficient: selfSufficient, isSecret: isSecret, isPublishOptionalData: isPublishOptionalData)
        apiClient.send(request, completion: completion)
    }

    func getGraphs(completion: @escaping ((Result<[Graph], PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetGraphsRequest(configuration: configuration)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.graphs))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getGraphSVGURL(id: String, date: Date?, mode: GraphSVGMode?) -> URL {
        let configuration = fetchConfiguration()
        return getGraphSVGURL(username: configuration.username, id: id, date: date, mode: mode)
    }

    func getGraphSVGURL(username: String, id: String, date: Date?, mode: GraphSVGMode?) -> URL {
        if let date = date, let mode = mode {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)?date=\(date.formatString())&mode=\(mode.rawValue)")!
        } else if let date = date {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)?date=\(date.formatString())")!
        } else if let mode = mode {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)?mode=\(mode.rawValue)")!
        } else {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)")!
        }
    }

    func updateGraph(id: String, name: String?, unit: String?, color: GraphColor?, timeZone: TimeZone?, purgeCacheURLs: [URL]?, selfSufficient: GraphSelfSufficient?, isSecret: Bool?, isPublishOptionalData: Bool?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdateGraphRequest(configuration: configuration, id: id, name: name, unit: unit, color: color, timeZone: timeZone, purgeCacheURLs: purgeCacheURLs, selfSufficient: selfSufficient, isSecret: isSecret, isPublishOptionalData: isPublishOptionalData)
        apiClient.send(request, completion: completion)
    }

    func deleteGraph(id: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteGraphRequest(configuration: configuration, id: id)
        apiClient.send(request, completion: completion)
    }

    func getGraphHTMLURL(id: String, mode: GraphHTMLMode?) -> URL {
        let configuration = fetchConfiguration()
        return getGraphHTMLURL(username: configuration.username, id: id, mode: mode)
    }

    func getGraphHTMLURL(username: String, id: String, mode: GraphHTMLMode?) -> URL {
        if let mode = mode {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id).html?mode=\(mode.rawValue)")!
        } else {
            return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id).html")!
        }
    }

    func getGraphsHTMLURL() -> URL {
        let configuration = fetchConfiguration()
        return getGraphsHTMLURL(username: configuration.username)
    }

    func getGraphsHTMLURL(username: String) -> URL {
        return URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs.html")!
    }

    func getGraphPixels(id: String, from: Date?, to: Date?, completion: @escaping ((Result<[String], PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetGraphPixelsRequest(configuration: configuration, id: id, from: from, to: to)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.pixels))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getGraphStatistics(id: String, completion: @escaping ((Result<GraphStatistics, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetGraphStatisticsRequest(configuration: configuration, id: id)
        apiClient.send(request, completion: completion)
    }
}
