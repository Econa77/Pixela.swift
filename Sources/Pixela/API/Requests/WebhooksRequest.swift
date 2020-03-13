//
//  WebhooksRequest.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-webhook
    struct CreateWebhookRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let type: Webhook.WebhookType

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/webhooks"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["graphID"] = graphID
            params["type"] = type.rawValue
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let webhookHash: String

        }

    }

    // @see https://docs.pixe.la/entry/get-webhooks
    struct GetWebhooksRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration

        // MARK: - Request Type
        typealias Response = RequestResponse

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/webhooks"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        // MARK: - Response
        struct RequestResponse: Decodable {

            // MARK: - Properties
            let webhooks: [Webhook]

        }

    }

    // @see https://docs.pixe.la/entry/invoke-webhook
    struct InvokeWebhookRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let webhookHash: String

        // MARK: - Reqeust Type
        typealias Response = Void

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/webhooks/\(webhookHash)"
        }
        var headerFields: [String : String] {
            return ["Content-Length": "0"]
        }

    }

    // @see https://docs.pixe.la/entry/delete-webhook
    struct DeleteWebhookRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let webhookHash: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(configuration.username)/webhooks/\(webhookHash)"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

}
