//
//  ExchangeSDK.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

public struct ExchangeSdk {
    static func buildInchExchangeService(debugMode: Bool) -> ExchangeServiceProtocol {
        return ExchangeService(debugMode: debugMode)
    }
    
    static func buildInchLimitService(debugMode: Bool) -> LimitOrderServiceProtocol {
        return LimitOrderService(debugMode: debugMode)
    }
}
