//
//  PixelaRequest.swift
//  APIKit
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation
import APIKit

protocol PixelaRequest: Request {}

extension PixelaRequest {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
}

extension PixelaRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            throw PixelaError.responseFailed(.unacceptableStatusCode(object, urlResponse.statusCode))
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
