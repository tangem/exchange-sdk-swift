//
//  InfoDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public struct InfoTokensDTO: Decodable {
    public let tokens: [String: TokenDTO]
}

// MARK: - Token

public struct TokenDTO: Decodable {
    public let symbol: String
    public let name: String
    public let decimals: Int
    public let address: String
    public let logoURI: String
    public let tags: [String]
    public let eip2612: Bool?
    public let isFoT: Bool
    public let domainVersion: String?
    public let synth: Bool?
    public let displayedSymbol: String?
}

public struct PresetsConfigurationDTO: Decodable {
    public let maxResult: [GasDTO]?
    public let lowestGas: [GasDTO]?

    enum CodingKeys: String, CodingKey {
        case maxResult = "MAX_RESULT"
        case lowestGas = "LOWEST_GAS"
    }
}

public struct GasDTO: Decodable {
    public let complexityLevel: Int
    public let mainRouteParts: Int
    public let parts: Int
    public let virtualParts: Int
}

public struct LiquiditySourcesDTO: Decodable {
    public let protocols: [LiquidityProtocol]
}

public struct LiquidityProtocol: Decodable {
    public let id: String
    public let title: String
    public let img: String
    public let imgColor: String?
    
    enum CodingKeys: String, CodingKey {
        case imgColor = "img_color"
        case id
        case img
        case title
    }
}
