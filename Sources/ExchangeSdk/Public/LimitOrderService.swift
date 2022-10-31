//
//  LimitOrderService.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public protocol LimitOrderServiceProtocol: AnyObject {
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrder], ExchangeInchError>
    func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrder], ExchangeInchError>
    func countOrders(blockchain: ExchangeBlockchain, statuses: [ExchangeOrderStatus]) async -> Result<CountLimitOrders, ExchangeInchError>
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrder], ExchangeInchError>
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String) async -> Result<Bool, ExchangeInchError>
}

class LimitOrderService: LimitOrderServiceProtocol {
    let debugMode: Bool
    private lazy var networkService: NetworkService = NetworkService(debugMode: debugMode)
    
    init(debugMode: Bool) {
        self.debugMode = debugMode
    }
    
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrder], ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: LimitOrderTarget.ordersForAddress(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrder].self)
        
    }
    
    func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrder], ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: LimitOrderTarget.allOrders(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrder].self)
    }
    
    func countOrders(blockchain: ExchangeBlockchain, statuses: [ExchangeOrderStatus]) async -> Result<CountLimitOrders, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: LimitOrderTarget.countOrders(blockchain: blockchain, statuses: statuses)),
                                           decodingObject: CountLimitOrders.self)
    }
    
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrder], ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: LimitOrderTarget.events(blockchain: blockchain, limit: limit)),
                                            decodingObject: [EventsLimitOrder].self)
    }
    
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain,
                                          walletAddress: String,
                                          tokenAddress: String) async -> Result<Bool, ExchangeInchError> {
        let target = LimitOrderTarget.hasActiveOrdersWithPermit(blockchain: blockchain,
                                                                walletAddress: walletAddress,
                                                                tokenAddress: tokenAddress)
        
        let response = await networkService.request(with: BaseTarget(target: target),
                                            decodingObject: ActiveOrdersWithPermitDTO.self)
        switch response {
        case .success(let dto):
            return .success(dto.result)
        case .failure(let error):
            return .failure(error)
        }
    }
}
