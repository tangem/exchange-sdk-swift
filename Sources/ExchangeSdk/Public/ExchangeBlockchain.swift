//
//  ExchangeBlockchain.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public enum ExchangeBlockchain {
    case ethereum
    case bsc
    case polygon
    case optimism
    case arbitrum
    case gnosis
    case avalanche
    case fantom
    case klayth
    case aurora
    
    var id: String {
        switch self {
        case .ethereum:
            return "1"
        case .bsc:
            return "56"
        case .polygon:
            return "137"
        case .optimism:
            return "10"
        case .arbitrum:
            return "42161"
        case .gnosis:
            return "100"
        case .avalanche:
            return "43114"
        case .fantom:
            return "250"
        case .klayth:
            return "8217"
        case .aurora:
            return "1313161554"
        }
    }
}
