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
        public let makerAsset, takerAsset, getMakerAmount, getTakerAmount: String
        public let makerAssetData, takerAssetData, salt, permit: String
        public let predicate, interaction, receiver, allowedSender: String
        public let makingAmount, takingAmount, maker: String
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
