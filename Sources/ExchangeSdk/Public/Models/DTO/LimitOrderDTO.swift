//
//  LimitOrderDTO.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

/// - limit-order/address/{address}
/// - limit-order/all
public struct LimitOrderDTO: Codable {
    public let signature: String
    public let orderHash: String
    public let createDateTime: String
    public let remainingMakerAmount: String
    public let makerAllowance: String
    public let takerRate: String
    public let makerBalance : String
    public let data: MetaData
    public let makerRate: String
    public let isMakerContract: Bool
    
    public struct MetaData: Codable {
        /// maker asset -> "you sell"
        /// taker asset -> "you buy"

        public let makerAsset: String
        public let getMakerAmount: String
        public let getTakerAmount: String
        public let takerAsset: String
        public let makerAssetData: String
        public let takerAssetData: String
        public let salt: String
        public let permit: String
        public let predicate: String
        public let allowedSender: String
        public let receiver: String
        public let interaction: String
        public let makingAmount: String
        public let maker: String
        public let takingAmount: String
    }
}

public struct CountLimitOrdersDTO: Decodable {
    public let count: Int
}

public struct EventsLimitOrderDTO: Decodable {
    public let id: Int
    public let network: Int
    public let logID: String
    public let version: Int
    public let action: String
    public let orderHash: String
    public let taker: String
    public let remainingMakerAmount: String
    public let transactionHash: String
    public let blockNumber: Int
    public let createDateTime: String
    
    enum CodingKeys: String, CodingKey {
        case logID = "logId"
        case id
        case network
        case version
        case createDateTime
        case blockNumber
        case transactionHash
        case action
        case orderHash
        case taker
        case remainingMakerAmount
    }
}

public struct ActiveOrdersWithPermitDTO: Decodable {
    public let result: Bool
}
