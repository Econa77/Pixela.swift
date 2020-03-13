//
//  NotificationsRequest.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-notification
    struct CreateNotificationRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let id: String
        let name: String
        let target: NotificationTarget
        let condition: NotificationCondition
        let threshold: String
        let channelID: String

        // MARK: - Request Type
        typealias Response = Notification

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/notifications"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["id"] = id
            params["name"] = name
            params["target"] = target.rawValue
            params["condition"] = condition.rawValue
            params["threshold"] = threshold
            params["channelID"] = channelID
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Notification {
            return Notification(id: id, name: name, target: target, condition: condition, threshold: threshold, channelID: channelID)
        }

    }

    // @see https://docs.pixe.la/entry/get-notifications
    struct GetNotificationsRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/notifications"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let notifications: [Notification]

        }

    }

    // @see https://docs.pixe.la/entry/put-notification
    struct UpdateNotificationRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let id: String
        let name: String?
        let target: NotificationTarget?
        let condition: NotificationCondition?
        let threshold: String?
        let channelID: String?

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/notifications/\(id)"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["name"] = name
            params["target"] = target?.rawValue
            params["condition"] = condition?.rawValue
            params["threshold"] = threshold
            params["channelID"] = channelID
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/delete-notification
    struct DeleteNotificationRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let id: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/notifications/\(id)"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

}
