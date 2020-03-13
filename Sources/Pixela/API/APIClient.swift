//
//  APIClient.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation
import APIKit

final class APIClient {

    // MARK: - Properties
    private let session: Session

    // MARK: - Initialize
    init(session: Session) {
        self.session = session
    }

    // MARK: - Request
    @discardableResult
    func send<T: PixelaRequest>(_ request: T, completion: @escaping (Result<T.Response, PixelaError>) -> Void) -> SessionTask? {
        let task = session.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                switch error {
                case .requestError:
                    completion(.failure(.requestFailed))
                case .connectionError:
                    completion(.failure(.connectionFailed))
                case let .responseError(responseError):
                    if let responseError = responseError as? PixelaError {
                        completion(.failure(responseError))
                    } else {
                        completion(.failure(.responseFailed(.invalidError(responseError))))
                    }
                }
            }
        }
        return task
    }

}
