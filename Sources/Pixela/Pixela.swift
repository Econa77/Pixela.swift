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
    func createChannel(id: String, name: String, type: Channel.ChannelType, completion: @escaping ((Result<Channel, PixelaError>) -> Void)) {
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

    func updateChannel(id: String, name: String?, type: Channel.ChannelType?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
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
    func createGraph(id: String, name: String, unit: String, type: Graph.GraphType, color: Graph.Color, timeZone: TimeZone?, selfSufficient: Graph.SelfSufficient?, isSecret: Bool?, isPublishOptionalData: Bool?, completion: @escaping ((Result<Graph, PixelaError>) -> Void)) {
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

    func getGraphSVGURL(id: String, date: Date?, mode: Graph.SVGMode?, appearance: Graph.Appearance?) -> URL {
        let configuration = fetchConfiguration()
        return getGraphSVGURL(username: configuration.username, id: id, date: date, mode: mode, appearance: appearance)
    }

    func getGraphSVGURL(username: String, id: String, date: Date?, mode: Graph.SVGMode?, appearance: Graph.Appearance?) -> URL {
        var components = URLComponents(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)")
        var queryItems = [URLQueryItem]()
        if let date = date {
            queryItems.append(URLQueryItem(name: "date", value: date.formatString()))
        }
        if let mode = mode {
            queryItems.append(URLQueryItem(name: "mode", value: mode.rawValue))
        }
        if let appearance = appearance {
            queryItems.append(URLQueryItem(name: "appearance", value: appearance.rawValue))
        }
        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }
        return components?.url ?? URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id)")!
    }

    func updateGraph(id: String, name: String?, unit: String?, color: Graph.Color?, timeZone: TimeZone?, purgeCacheURLs: [URL]?, selfSufficient: Graph.SelfSufficient?, isSecret: Bool?, isPublishOptionalData: Bool?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdateGraphRequest(configuration: configuration, id: id, name: name, unit: unit, color: color, timeZone: timeZone, purgeCacheURLs: purgeCacheURLs, selfSufficient: selfSufficient, isSecret: isSecret, isPublishOptionalData: isPublishOptionalData)
        apiClient.send(request, completion: completion)
    }

    func deleteGraph(id: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteGraphRequest(configuration: configuration, id: id)
        apiClient.send(request, completion: completion)
    }

    func getGraphHTMLURL(id: String, mode: Graph.HTMLMode?) -> URL {
        let configuration = fetchConfiguration()
        return getGraphHTMLURL(username: configuration.username, id: id, mode: mode)
    }

    func getGraphHTMLURL(username: String, id: String, mode: Graph.HTMLMode?) -> URL {
        var components = URLComponents(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id).html")
        var queryItems = [URLQueryItem]()
        if let mode = mode {
            queryItems.append(URLQueryItem(name: "mode", value: mode.rawValue))
        }
        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }
        return components?.url ?? URL(string: "\(PixelaAPI.baseURLString)/v1/users/\(username)/graphs/\(id).html")!
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

    func getGraphStatistics(id: String, completion: @escaping ((Result<Graph.Statistics, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetGraphStatisticsRequest(configuration: configuration, id: id)
        apiClient.send(request, completion: completion)
    }
}

// MARK: - Pixels Request
public extension Pixela {
    func recordPixel(graphID: String, date: Date, quantity: String, optionalData: [String: Any]?, completion: @escaping ((Result<Pixel, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.RecordPixelRequest(configuration: configuration, graphID: graphID, date: date, quantity: quantity, optionalData: optionalData)
        apiClient.send(request, completion: completion)
    }

    func getPixel(graphID: String, date: Date, completion: @escaping ((Result<Pixel, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetPixelRequest(configuration: configuration, graphID: graphID, date: date)
        apiClient.send(request, completion: completion)
    }

    func updatePixel(graphID: String, date: Date, quantity: String?, optionalData: [String: Any]?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdatePixelRequest(configuration: configuration, graphID: graphID, date: date, quantity: quantity, optionalData: optionalData)
        apiClient.send(request, completion: completion)
    }

    func incrementPixel(graphID: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.IncrementPixelRequest(configuration: configuration, graphID: graphID)
        apiClient.send(request, completion: completion)
    }

    func decrementPixel(graphID: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DecrementPixelRequest(configuration: configuration, graphID: graphID)
        apiClient.send(request, completion: completion)
    }

    func deletePixel(graphID: String, date: Date, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeletePixelRequest(configuration: configuration, graphID: graphID, date: date)
        apiClient.send(request, completion: completion)
    }
}

// MARK: - Notifications Request
public extension Pixela {
    func createNotification(graphID: String, id: String, name: String, target: Notification.Target, condition: Notification.Condition, threshold: String, channelID: String, completion: @escaping ((Result<Notification, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.CreateNotificationRequest(configuration: configuration, graphID: graphID, id: id, name: name, target: target, condition: condition, threshold: threshold, channelID: channelID)
        apiClient.send(request, completion: completion)
    }

    func getNotifications(graphID: String, completion: @escaping ((Result<[Notification], PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetNotificationsRequest(configuration: configuration, graphID: graphID)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.notifications))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func updateNotification(graphID: String, id: String, name: String?, target: Notification.Target?, condition: Notification.Condition?, threshold: String?, channelID: String?, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.UpdateNotificationRequest(configuration: configuration, graphID: graphID, id: id, name: name, target: target, condition: condition, threshold: threshold, channelID: channelID)
        apiClient.send(request, completion: completion)
    }

    func deleteNotification(graphID: String, id: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteNotificationRequest(configuration: configuration, graphID: graphID, id: id)
        apiClient.send(request, completion: completion)
    }
}

// MARK: - Webhooks Request
public extension Pixela {
    func createWebhook(graphID: String, type: Webhook.WebhookType, completion: @escaping ((Result<Webhook, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.CreateWebhookRequest(configuration: configuration, graphID: graphID, type: type)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(Webhook(webhookHash: response.webhookHash, graphID: graphID, type: type)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getWebhooks(completion: @escaping ((Result<[Webhook], PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.GetWebhooksRequest(configuration: configuration)
        apiClient.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.webhooks))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func invokeWebhook(webhookHash: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.InvokeWebhookRequest(configuration: configuration, webhookHash: webhookHash)
        apiClient.send(request, completion: completion)
    }

    func deleteWebhook(webhookHash: String, completion: @escaping ((Result<Void, PixelaError>) -> Void)) {
        let configuration = fetchConfiguration()
        let request = PixelaAPI.DeleteWebhookRequest(configuration: configuration, webhookHash: webhookHash)
        apiClient.send(request, completion: completion)
    }
}
