//
//  LimitOrderFacade.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public protocol LimitOrderFacade: AnyObject {
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError>
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError>
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String) async -> Result<Bool, ExchangeError>
}

public class LimitOrderService: LimitOrderFacade {
    let debugMode: Bool
    private lazy var networkFacade: NetworkFacade = NetworkFacade(debugMode: debugMode)
    
    init(debugMode: Bool) {
        self.debugMode = debugMode
    }
    
    public func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.ordersForAddress(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrderDTO].self)
        
    }
    
    public func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.allOrders(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrderDTO].self)
    }
    
    public func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.countOrders(blockchain: blockchain, statuses: statuses)),
                                           decodingObject: CountLimitOrdersDTO.self)
    }
    
    public func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.events(blockchain: blockchain, limit: limit)),
                                            decodingObject: [EventsLimitOrderDTO].self)
    }
    
    public func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain,
                                          walletAddress: String,
                                          tokenAddress: String) async -> Result<Bool, ExchangeError> {
        let target = LimitOrderTarget.hasActiveOrdersWithPermit(blockchain: blockchain,
                                                                walletAddress: walletAddress,
                                                                tokenAddress: tokenAddress)
        
        let response = await networkFacade.request(with: BaseTarget(target: target),
                                            decodingObject: ActiveOrdersWithPermitDTO.self)
        switch response {
        case .success(let dto):
            return .success(dto.result)
        case .failure(let error):
            return .failure(error)
        }
    }
}
