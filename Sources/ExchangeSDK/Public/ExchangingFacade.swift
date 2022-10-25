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
    
    public init(enableDebugMode: Bool = false) {
        self.debugMode = enableDebugMode
    }
    
    public func healthCheck(blockchain: ExchangeBlockchain) async -> Result<HealthCheckDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: HealthCheckTarget.healthCheck(blockchain: blockchain)),
                                                   decodingObject: HealthCheckDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func tokens(blockchain: ExchangeBlockchain) async -> Result<InfoTokensDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InfoTarget.tokens(blockchain: blockchain)),
                                                   decodingObject: InfoTokensDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func presets(blockchain: ExchangeBlockchain) async -> Result<PresetsConfigurationDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InfoTarget.presets(blockchain: blockchain)),
                                                   decodingObject: PresetsConfigurationDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func liquiditySources(blockchain: ExchangeBlockchain) async -> Result<LiquiditySourcesDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InfoTarget.liquiditySources(blockchain: blockchain)),
                                                   decodingObject: LiquiditySourcesDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func quote(blockchain: ExchangeBlockchain, parameters: QuoteParameters) async -> Result<QuoteDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: SwapTarget.quote(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: QuoteDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func swap(blockchain: ExchangeBlockchain, parameters: SwapParameters) async -> Result<SwapDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: SwapTarget.swap(blockchain: blockchain, parameters: parameters)),
                                                   decodingObject: SwapDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func spender(blockchain: ExchangeBlockchain) async -> Result<ApproveSpenderDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InchApprove.spender(blockchain: blockchain)),
                                                   decodingObject: ApproveSpenderDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func approveTransaction(blockchain: ExchangeBlockchain, approveTransactionParameters: ApproveTransactionParameters) async -> Result<ApproveTransactionDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InchApprove.transaction(blockchain: blockchain, params: approveTransactionParameters)),
                                                   decodingObject: ApproveTransactionDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func allowance(blockchain: ExchangeBlockchain, allowanceParameters: ApproveAllowanceParameters) async -> Result<ApproveAllowanceDTO, ExchangeError> {
        let response = await networkFacade.request(with: BaseTarget(target: InchApprove.allowance(blockchain: blockchain, params: allowanceParameters)),
                                                   decodingObject: ApproveAllowanceDTO.self)
        
        switch response {
        case .success(let decodedResponse):
            return .success(decodedResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
}
