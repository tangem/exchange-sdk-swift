//
//  SwapDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

// MARK: - Quote

public struct QuoteDTO: Decodable {
    public let fromToken: TokenInfoDTO
    public let toToken: TokenInfoDTO
    public let toTokenAmount: String
    public let fromTokenAmount: String
    public let protocols: [[[ProtocolElementDTO]]]
    public let estimatedGas: Int
}

public struct TokenInfoDTO: Decodable {
    public let symbol: String
    public let name: String
    public let address: String
    public let decimals: Int
    public let logoURI: String
}

public struct ProtocolElementDTO: Decodable {
    public let name: String
    public let part: Int
    public let fromTokenAddress: String
    public let toTokenAddress: String
}

// MARK: - Swap

public struct SwapDTO: Decodable {
    public let fromToken: SwapTokenDTO
    public let toToken: SwapTokenDTO
    public let toTokenAmount: String
    public let fromTokenAmount: String
    public let protocols: [[[ProtocolElementDTO]]]
    public let tx: TransactionDTO
}

public struct SwapTokenDTO: Decodable {
    public let symbol: String
    public let name: String
    public let decimals: Int
    public let address: String
    public let logoURI: String
    public let tags: [String]
}

public struct TransactionDTO: Codable {
    public let from: String
    public let to: String
    public let data: String
    public let value: String
    public let gas: Int
    // GWEI
    public let gasPrice: String
}

