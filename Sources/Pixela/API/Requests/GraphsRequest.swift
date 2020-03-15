//
//  GraphsRequest.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/13.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-graph
    struct CreateGraphRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String
        let name: String
        let unit: String
        let type: Graph.GraphType
        let color: Graph.Color
        let timeZone: TimeZone?
        let selfSufficient: Graph.SelfSufficient?
        let isSecret: Bool?
        let isPublishOptionalData: Bool?

        // MARK: - ResponseType
        typealias Response = Graph

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/graphs"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["id"] = id
            params["name"] = name
            params["unit"] = unit
            params["type"] = type.rawValue
            params["color"] = color.rawValue
            params["timezone"] = timeZone?.identifier
            params["selfSufficient"] = selfSufficient?.rawValue
            params["isSecret"] = isSecret
            params["publishOptionalData"] = isPublishOptionalData
            return params
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Graph {
            return Graph(id: id, name: name, unit: unit, type: type, color: color, purgeCacheURLs: [], timeZone: timeZone, selfSufficient: selfSufficient ?? .none, isSecret: isSecret, isPublishOptionalData: isPublishOptionalData)
        }

    }

    // @see https://docs.pixe.la/entry/get-graph
    struct GetGraphsRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/graphs"
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let graphs: [Graph]

        }

    }

    // @see https://docs.pixe.la/entry/put-graph
    struct UpdateGraphRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String
        let name: String?
        let unit: String?
        let color: Graph.Color?
        let timeZone: TimeZone?
        let purgeCacheURLs: [URL]?
        let selfSufficient: Graph.SelfSufficient?
        let isSecret: Bool?
        let isPublishOptionalData: Bool?

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(id)"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["name"] = name
            params["unit"] = unit
            params["color"] = color?.rawValue
            params["timezone"] = timeZone?.identifier
            params["purgeCacheURLs"] = purgeCacheURLs?.map { $0.absoluteString }
            params["selfSufficient"] = selfSufficient?.rawValue
            params["isSecret"] = isSecret
            params["publishOptionalData"] = isPublishOptionalData
            return params
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/delete-graph
    struct DeleteGraphRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(id)"
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/get-graph-pixels
    struct GetGraphPixelsRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String
        let from: Date?
        let to: Date?

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(id)/pixels"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["from"] = from?.formatString()
            params["to"] = to?.formatString()
            return params
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let pixels: [String]

        }

    }

    // @see https://docs.pixe.la/entry/get-graph-stats
    struct GetGraphStatisticsRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String

        // MARK: - Request Type
        typealias Response = Graph.Statistics

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(id)/stats"
        }
        var headerFields: [String: String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

}
