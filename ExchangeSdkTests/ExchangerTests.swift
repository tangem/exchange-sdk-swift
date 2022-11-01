//
//  ExchangerTests.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import XCTest
@testable import ExchangeSdk

final class ExchangerTests: XCTestCase {
    let exchange: ExchangeServiceProtocol = ExchangeSdk.buildInchExchangeService(isDebug: true)
    
    func testHealth() async {
        let health = await exchange.healthCheck(blockchain: .bsc)
        switch health {
        case .success(let dto):
            XCTAssert(dto.status.contains("OK"))
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testInfoTokens() async {
        let tokens = await exchange.tokens(blockchain: .polygon)
        
        switch tokens {
        case .success(let dto):
            XCTAssert(!dto.tokens.isEmpty)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testPresets() async {
        let presets = await exchange.presets(blockchain: .polygon)
        
        switch presets {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testLiquidity() async {
        let liq = await exchange.liquiditySources(blockchain: .ethereum)
        
        switch liq {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testQuote() async {
        let parameters = QuoteParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                         toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                         amount: "10000000000000000")
        
        let response = await exchange.quote(blockchain: .polygon,
                                            parameters: parameters)
        switch response {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testGeneratingSwap() async {
        let amount = 100_000_000_000_000_000
        let parameters = SwapParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                        toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                        amount: "\(amount)",
                                        fromAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c",
                                        slippage: 1)
        
        let response = await exchange.swap(blockchain: .polygon,
                                           parameters: parameters)
        switch response {
        case .success(let dto):
            XCTAssert(!dto.tx.data.isEmpty)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testGeneratingSwapWithErrorCannotEstimate() async {
        let amount = 900_000_000_000_000_000
        let parameters = SwapParameters(fromTokenAddress: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                        toTokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
                                        amount: "\(amount)",
                                        fromAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c",
                                        slippage: 1)
        
        let response = await exchange.swap(blockchain: .polygon,
                                           parameters: parameters)
        switch response {
        case .success:
            XCTAssert(false)
        case .failure(let error):
            switch error {
            case .decodeError, .serverError, .unknownError:
                XCTAssert(false, error.localizedDescription)
            case .parsedError(let errorInfo):
                XCTAssert(errorInfo.description.contains("cannot estimate"))
            }
        }
    }
    
    func testApproveSpender() async {
        let spenderAddress = "0x1111111254fb6c44bac0bed2854e76f90643097d"
        let response = await exchange.spender(blockchain: .ethereum)
        
        switch response {
        case .success(let dto):
            XCTAssert(dto.address == spenderAddress)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testApproveTransactionData() async {
        let response = await exchange.approveTransaction(blockchain: .polygon, approveTransactionParameters: .init(
            tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063",
            amount: .infinite))
        
        switch response {
        case .success(let dto):
            XCTAssert(!dto.data.isEmpty)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testApproveAllowance() async {
        let response = await exchange.allowance(blockchain: .polygon, allowanceParameters: .init(
            tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063", // DAI in polygon network
            walletAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c")) // Your wallet address
        
        switch response {
        case .success(let dto):
            let decimalAllowance = Decimal(string: dto.allowance) ?? 0
            XCTAssert(decimalAllowance > 0)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
}
