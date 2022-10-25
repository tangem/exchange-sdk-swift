import Foundation

public protocol LimitOrderFacade: AnyObject {
    /// Get limit order for specific address
    func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    
    /// All orders in 1inch
    func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrderDTO], ExchangeError>
    
    /// Count of all limit orders
    func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError>
    
    /// Get all events
    func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError>
    func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain, walletAddress: String, tokenAddress: String) async -> Result<ActiveOrdersWithPermitDTO, ExchangeError>
}

public class LimitOrderService: LimitOrderFacade {
    let enableDebugMode: Bool
    private lazy var networkFacade: NetworkFacade = NetworkFacade(debugMode: enableDebugMode)
    
    init(enableDebugMode: Bool) {
        self.enableDebugMode = enableDebugMode
    }
    
    public func ordersForAddress(blockchain: ExchangeBlockchain, parameters: OrdersForAddressParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.ordersForAddress(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrderDTO].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func allOrders(blockchain: ExchangeBlockchain, parameters: AllOrdersParameters) async -> Result<[LimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.allOrders(blockchain: blockchain, parameters: parameters)), decodingObject: [LimitOrderDTO].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func countOrders(blockchain: ExchangeBlockchain, statuses: [Statuses]) async -> Result<CountLimitOrdersDTO, ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.countOrders(blockchain: blockchain, statuses: statuses)),
                                                           decodingObject: CountLimitOrdersDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func events(blockchain: ExchangeBlockchain, limit: Int) async -> Result<[EventsLimitOrderDTO], ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.events(blockchain: blockchain, limit: limit)),
                                                           decodingObject: [EventsLimitOrderDTO].self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
    
    public func hasActiveOrdersWithPermit(blockchain: ExchangeBlockchain,
                                          walletAddress: String,
                                          tokenAddress: String) async -> Result<ActiveOrdersWithPermitDTO, ExchangeError> {
        await withCheckedContinuation({ continuation in
            Task {
                let response = await networkFacade.request(with: BaseTarget(target: LimitOrderTarget.hasActiveOrdersWithPermit(blockchain: blockchain,
                                                                                                                              walletAddress: walletAddress,
                                                                                                                              tokenAddress: tokenAddress)),
                                                           decodingObject: ActiveOrdersWithPermitDTO.self)
                
                switch response {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
}
