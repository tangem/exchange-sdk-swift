//
//  ExchangingFacade.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation

public protocol ExchangingFacade: AnyObject {
    /// Check status of service
    /// - Parameter blockchain: blockchain
    func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, ExchangeError>
    
    /// blockchainID/tokens
    /// - Parameter blockchain: ExchangeBlockchain type
    /// - Returns: request result
    func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, ExchangeError>
    func presets(blockchain: ExchangeBlockchain) async -> Result<PresetsConfigurationDTO, ExchangeError>
    func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, ExchangeError>
    
    /// Find best quote to exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func quote(blockchain: ExchangeBlockchain,
               parameters: QuoteParameters) async -> Result<QuoteDTO, ExchangeError>
    
    /// Generating data for exchange
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - parameters: parameters for exchange
    func swap(blockchain: ExchangeBlockchain,
              parameters: SwapParameters) async -> Result<SwapDTO, ExchangeError>
    
    /// Address of the 1inch router that must be trusted to spend funds for the exchange
    /// - Parameter blockchain: blockchain type
    /// - Returns: parameters for exchange
    func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpenderDTO, ExchangeError>
    
    /// Generate data for calling the contract in order to allow the 1inch router to spend funds
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - approveTransactionParameters: parameters for exchange
    func approveTransaction(blockchain: ExchangeBlockchain,
                            approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApproveTransactionDTO, ExchangeError>
    
    /// Get the number of tokens that the 1inch router is allowed to spend
    /// - Parameters:
    ///   - blockchain: blockchain type
    ///   - allowanceParameters: parameters for exchange
    func allowance(blockchain: ExchangeBlockchain,
                   allowanceParameters: ApproveAllowanceParameters) async -> Result<ApproveAllowanceDTO, ExchangeError>
}

public class ExchangeFacade: ExchangingFacade {
    let debugMode: Bool
    private lazy var networkFacade: NetworkFacade = NetworkFacade(debugMode: debugMode)
    
    public init(debugMode: Bool = false) {
        self.debugMode = debugMode
    }
    
    public func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: HealthCheckTarget.healthCheck(blockchain: blockchain)),
                                                   decodingObject: HealthCheckDTO.self)
    }
    
    public func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InfoTarget.tokens(blockchain: blockchain)),
                                                   decodingObject: InfoTokensDTO.self)
    }
    
    public func presets(blockchain: ExchangeBlockchain) async -> Result<PresetsConfigurationDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InfoTarget.presets(blockchain: blockchain)),
                                                   decodingObject: PresetsConfigurationDTO.self)
    }
    
    public func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InfoTarget.liquiditySources(blockchain: blockchain)),
                                                   decodingObject: LiquiditySourcesDTO.self)
    }
    
    public func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: SwapTarget.quote(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: QuoteDTO.self)
    }
    
    public func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: SwapTarget.swap(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: SwapDTO.self)
    }
    
    public func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpenderDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InchApprove.spender(blockchain: blockchain)),
                                                   decodingObject: ApproveSpenderDTO.self)
    }
    
    public func approveTransaction(blockchain: ExchangeBlockchain, approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApproveTransactionDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InchApprove.transaction(blockchain: blockchain, params: approveTransactionParameters)),
                                                   decodingObject: ApproveTransactionDTO.self)
    }
    
    public func allowance(blockchain: ExchangeBlockchain, allowanceParameters: ApproveAllowanceParameters) async -> Result<ApproveAllowanceDTO, ExchangeError> {
        return await networkFacade.request(with: BaseTarget(target: InchApprove.allowance(blockchain: blockchain, params: allowanceParameters)),
                                                   decodingObject: ApproveAllowanceDTO.self)
    }
}
