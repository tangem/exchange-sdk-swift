//
//  ExchangingFacade.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public protocol ExchangeServiceProtocol: AnyObject {
    // Check status of service
    func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheck, ExchangeInchError>
    func tokens(blockchain: ExchangeBlockchain) async -> Result<TokensList, ExchangeInchError>
    
    func presets(blockchain: ExchangeBlockchain) async -> Result<PresetsConfiguration, ExchangeInchError>
    func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesList, ExchangeInchError>
    
    // Find best quote to exchange
    func quote(blockchain: ExchangeBlockchain,
               parameters: QuoteParameters) async -> Result<QuoteData, ExchangeInchError>
    
    // Generating data for exchange
    func swap(blockchain: ExchangeBlockchain,
              parameters: SwapParameters) async -> Result<SwapData, ExchangeInchError>
    
    // Address of the 1inch router that must be trusted to spend funds for the exchange
    func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpender, ExchangeInchError>
    
    // Generate data for calling the contract in order to allow the 1inch router to spend funds
    func approveTransaction(blockchain: ExchangeBlockchain,
                            approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApprovedTransactionData, ExchangeInchError>
    
    // Get the number of tokens that the 1inch router is allowed to spend
    func allowance(blockchain: ExchangeBlockchain,
                   allowanceParameters: ApproveAllowanceParameters) async -> Result<ApprovedAllowance, ExchangeInchError>
}

class ExchangeService: ExchangeServiceProtocol {
    let debugMode: Bool
    private lazy var networkService: NetworkService = NetworkService(debugMode: debugMode)
    
    init(debugMode: Bool = false) {
        self.debugMode = debugMode
    }
    
    func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheck, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: HealthCheckTarget.healthCheck(blockchain: blockchain)),
                                                   decodingObject: HealthCheck.self)
    }
    
    func tokens(blockchain: ExchangeBlockchain) async -> Result<TokensList, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: InfoTarget.tokens(blockchain: blockchain)),
                                                   decodingObject: TokensList.self)
    }
    
    func presets(blockchain: ExchangeBlockchain) async -> Result<PresetsConfiguration, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: InfoTarget.presets(blockchain: blockchain)),
                                                   decodingObject: PresetsConfiguration.self)
    }
    
    func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesList, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: InfoTarget.liquiditySources(blockchain: blockchain)),
                                                   decodingObject: LiquiditySourcesList.self)
    }
    
    func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteData, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: SwapTarget.quote(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: QuoteData.self)
    }
    
    func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapData, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: SwapTarget.swap(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: SwapData.self)
    }
    
    func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpender, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: ApproveTarget.spender(blockchain: blockchain)),
                                                   decodingObject: ApproveSpender.self)
    }
    
    func approveTransaction(blockchain: ExchangeBlockchain, approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApprovedTransactionData, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: ApproveTarget.transaction(blockchain: blockchain, params: approveTransactionParameters)),
                                                   decodingObject: ApprovedTransactionData.self)
    }
    
    func allowance(blockchain: ExchangeBlockchain, allowanceParameters: ApproveAllowanceParameters) async -> Result<ApprovedAllowance, ExchangeInchError> {
        return await networkService.request(with: BaseTarget(target: ApproveTarget.allowance(blockchain: blockchain, params: allowanceParameters)),
                                                   decodingObject: ApprovedAllowance.self)
    }
}
