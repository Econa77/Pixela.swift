//
//  PixelaError.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/13.
//

import Foundation

public enum PixelaError: Error {
    case requestFailed
    case connectionFailed
    case responseFailed(ResponseErrorReason)
}

public enum ResponseErrorReason {
    case dataParsingFailed(Any, Error?, Int)
    case unacceptableStatusCode(Any, Int)
    case invalidError(Error)
}
