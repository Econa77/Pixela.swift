//
//  PixelsRequest.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-pixel
    struct RecordPixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let date: Date
        let quantity: String
        let optionalData: [String: Any]?

        // MARK: - Request Type
        typealias Response = Pixel

        let method: HTTPMethod = .post
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["date"] = date.formatString()
            params["quantity"] = quantity
            if let optinalData = self.optionalData, let jsonData = try? JSONSerialization.data(withJSONObject: optinalData, options: []) {
                params["optionalData"] = String(data: jsonData, encoding: .utf8)
            }
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Pixel {
            if let optinalData = self.optionalData, let jsonData = try? JSONSerialization.data(withJSONObject: optinalData, options: []) {
                return Pixel(quantity: quantity, optionalData: String(data: jsonData, encoding: .utf8))
            }
            return Pixel(quantity: quantity, optionalData: nil)
        }

    }

    // @see https://docs.pixe.la/entry/get-pixel
    struct GetPixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let date: Date

        // MARK: - Request Type
        typealias Response = Pixel

        let method: HTTPMethod = .get
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/\(date.formatString())"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/put-pixel
    struct UpdatePixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let date: Date
        let quantity: String?
        let optionalData: [String: Any]?

        // MARK: - Reqeust Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/\(date.formatString())"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["quantity"] = quantity
            if let optinalData = self.optionalData, let jsonData = try? JSONSerialization.data(withJSONObject: optinalData, options: []) {
                params["optionalData"] = String(data: jsonData, encoding: .utf8)
            }
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

    // @see https://docs.pixe.la/entry/increment-pixel
    struct IncrementPixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/increment"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token,
                    "Content-Length": "0"]
        }

    }

    // @see https://docs.pixe.la/entry/decrement-pixel
    struct DecrementPixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/decrement"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token,
                    "Content-Length": "0"]
        }

    }

    // @see https://docs.pixe.la/entry/delete-pixel
    struct DeletePixelRequest: PixelaRequest {

        // MARK: - Properties
        let configuration: Configuration
        let graphID: String
        let date: Date

        // MARK: - Request Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(configuration.username)/graphs/\(graphID)/\(date.formatString())"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": configuration.token]
        }

    }

}
