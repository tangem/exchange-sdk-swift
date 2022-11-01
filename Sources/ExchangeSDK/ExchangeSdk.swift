//
//  ExchangeSDK.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

public struct ExchangeSdk {
    static func buildInchExchangeService(isDebug: Bool) -> ExchangeServiceProtocol {
        return ExchangeService(isDebug: isDebug)
    }
    
    static func buildInchLimitService(isDebug: Bool) -> LimitOrderServiceProtocol {
        return LimitOrderService(isDebug: isDebug)
    }
}
