//
//  ErrorDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public enum ExchangeInchError: Error {
    case unknownError(statusCode: Int?)
    case serverError(withError: Error)
    case parsedError(withInfo: InchError)
    case decodeError(error: Error)
}

public struct InchError: Decodable, Error {
    public let statusCode: Int
    public let error: String
    public let description: String
    public let requestId: String
    public let meta: Meta
    
    public struct Meta: Decodable {
        public let type: String
        public let value: String
        
        internal init(type: String = "", value: String = "") {
            self.type = type
            self.value = value
        }
    }
    
    internal init(
        statusCode: Int,
        error: String = "",
        description: String = "",
        requestId: String = "",
        meta: InchError.Meta = .init()
    ) {
        self.statusCode = statusCode
        self.error = error
        self.description = description
        self.requestId = requestId
        self.meta = meta
    }
}
