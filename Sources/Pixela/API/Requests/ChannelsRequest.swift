//
//  ChannelsRequest.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/13.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-channel
    struct CreateChannelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String
        let name: String
        let type: Channel.ChannelType

        // MARK: - ResponseType
        typealias Response = Channel

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/channels"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["id"] = id
            params["name"] = name
            switch type {
            case let .slack(slack):
                params["type"] = Channel.NotificationType.slack.rawValue
                var detail = [String: Any]()
                detail["url"] = slack.url
                detail["userName"] = slack.userName
                detail["channelName"] = slack.channelName
                params["detail"] = detail
            }
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Channel {
            return Channel(id: id, name: name, type: type)
        }

    }

    // @see https://docs.pixe.la/entry/get-channels
    struct GetChannelsRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/channels"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let channels: [Channel]

        }

    }

    // @see https://docs.pixe.la/entry/put-channel
    struct UpdateChannelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String
        let name: String?
        let type: Channel.ChannelType?

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/channels/\(id)"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["name"] = name
            switch type {
            case let .some(.slack(slack)):
                params["type"] = Channel.NotificationType.slack.rawValue
                var detail = [String: Any]()
                detail["url"] = slack.url
                detail["userName"] = slack.userName
                detail["channelName"] = slack.channelName
                params["detail"] = detail
            case .none:
                break
            }
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/delete-channel
    struct DeleteChannelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let id: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(configuration.username)/channels/\(id)"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

}
