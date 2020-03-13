//
//  UsersRequest.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation
import APIKit

extension PixelaAPI {

    // @see https://docs.pixe.la/entry/post-user
    struct CreateUserRequest: PixelaRequest {

        // MARK: - Properties
        let token: String
        let username: String
        let isAgreeTermsOfService: Bool
        let isNotMinor: Bool
        let thanksCode: String?

        // MARK: - Request Type
        typealias Response = Configuration

        let method: HTTPMethod = .post
        let path: String = "/v1/users"
        var parameters: Any? {
            var params = [String: Any]()
            params["token"] = token
            params["username"] = username
            params["agreeTermsOfService"] = (isAgreeTermsOfService) ? "yes" : "no"
            params["notMinor"] = (isNotMinor) ? "yes" : "no"
            params["thanksCode"] = thanksCode
            return params
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Configuration {
            return Configuration(username: username, token: token)
        }

    }

    // @see https://docs.pixe.la/entry/put-user
    struct UpdateUserRequest: PixelaRequest {

        // MARK: - Properties
        let token: String
        let username: String
        let newToken: String?
        let thanksCode: String?

        // MARK: - Request Type
        typealias Response = Configuration

        let method: HTTPMethod = .put
        var path: String {
            return "/v1/users/\(username)"
        }
        var parameters: Any? {
            var params = [String: Any]()
            params["newToken"] = newToken
            params["thanksCode"] = thanksCode
            return params
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": token]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Configuration {
            return Configuration(username: username, token: newToken ?? token)
        }

    }

    // @see https://docs.pixe.la/entry/delete-user
    struct DeleteUserRequest: PixelaRequest {

        // MARK: - Properties
        let token: String
        let username: String

        // MARK: - Response Type
        typealias Response = Void

        let method: HTTPMethod = .delete
        var path: String {
            return "/v1/users/\(username)"
        }
        var headerFields: [String : String] {
            return ["X-USER-TOKEN": token]
        }

    }

}
