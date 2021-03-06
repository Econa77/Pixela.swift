//
//  PixelaRequest.swift
//  Pixela
//
//  Created by Shunsuke Furubayashi on 2020/03/13.
//

import Foundation
import APIKit

protocol PixelaRequest: Request {
    var apiConfiguration: APIConfiguration { get }
}

extension PixelaRequest {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    var baseURL: URL {
        return apiConfiguration.baseURL
    }
}

extension PixelaRequest {
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(apiConfiguration.userAgent, forHTTPHeaderField: "User-Agent")
        return urlRequest
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            guard let data = object as? Data else {
                throw PixelaError.responseFailed(.unacceptableStatusCode(object, nil, urlResponse.statusCode))
            }
            let decoder = JSONDecoder()
            let message = try? decoder.decode(Message.self, from: data)
            throw PixelaError.responseFailed(.unacceptableStatusCode(object, message, urlResponse.statusCode))
        }
        return object
    }
}

extension PixelaRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw PixelaError.responseFailed(.dataParsingFailed(object, nil, urlResponse.statusCode))
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw PixelaError.responseFailed(.dataParsingFailed(object, error, urlResponse.statusCode))
        }
    }
}

extension PixelaRequest where Response == Void {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws {
        return ()
    }
}
