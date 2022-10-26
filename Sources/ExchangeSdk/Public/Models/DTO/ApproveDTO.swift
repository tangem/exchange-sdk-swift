//
//  ApproveSpenderDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

// MARK: - Spender

public struct ApproveSpenderDTO: Decodable {
    public let address: String
}

// MARK: - Transaction

public struct ApproveTransactionDTO: Decodable {
    public let data: String
    public let gasPrice: String
    public let to: String
    public let value: String
}

// MARK: - Allowance

public struct ApproveAllowanceDTO: Decodable {
    public let allowance: String
}
