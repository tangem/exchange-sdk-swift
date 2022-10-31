//
//  SwapDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

// MARK: - Quote

public struct QuoteData: Decodable {
    public let fromToken: TokenInfo
    public let toToken: TokenInfo
    public let toTokenAmount: String
    public let fromTokenAmount: String
    public let protocols: [[[ProtocolInfo]]]
    public let estimatedGas: Int
}

public struct TokenInfo: Decodable {
    public let symbol: String
    public let name: String
    public let address: String
    public let decimals: Int
    public let logoURI: String
}

public struct ProtocolInfo: Decodable {
    public let name: String
    public let part: Int
    public let fromTokenAddress: String
    public let toTokenAddress: String
}

// MARK: - Swap

public struct SwapData: Decodable {
    public let fromToken: SwapTokenData
    public let toToken: SwapTokenData
    public let toTokenAmount: String
    public let fromTokenAmount: String
    public let protocols: [[[ProtocolInfo]]]
    public let tx: TransactionData
}

public struct SwapTokenData: Decodable {
    public let symbol: String
    public let name: String
    public let decimals: Int
    public let address: String
    public let logoURI: String
    public let tags: [String]
}

public struct TransactionData: Codable {
    public let from: String
    public let to: String
    public let data: String
    public let value: String
    public let gas: Int
    // GWEI
    public let gasPrice: String
}

