//
//  LimitTests.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import XCTest
@testable import ExchangeSdk

final class LimitTests: XCTestCase {
    let limit: LimitOrderServiceProtocol = ExchangeSdk.buildInchLimitService(debugMode: true)
    
    func testLimitForAddress() async {
        let response = await limit.ordersForAddress(blockchain: .polygon, parameters: .init(address: "0x2d45754375672e470E03beF24f4acC3cCD36973c"))
        
        let params = AllOrdersParameters.init(statuses: [.invalid, .temporaryInvalid])
        
        switch response {
        case .success(let objects):
            for object in objects {
                print(object)
            }
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testAllLimits() async {
        let response = await limit.allOrders(blockchain: .polygon, parameters: .init())
        
        switch response {
        case .success(let objects):
            for object in objects {
                print(object)
            }
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testCountOrders() async {
        let response = await limit.countOrders(blockchain: .polygon, statuses: [.valid, .temporaryInvalid])
        switch response {
        case .success(let object):
            print(object.count)
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testEvents() async {
        let response = await limit.events(blockchain: .polygon, limit: 100)
        switch response {
        case .success(let object):
            print(object)
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testActiveOrdersWithPermit() async {
        let response = await limit.hasActiveOrdersWithPermit(blockchain: .polygon,
                                                             walletAddress: "0x2d45754375672e470E03beF24f4acC3cCD36973c",
                                                             tokenAddress: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063")
        switch response {
        case .success(let object):
            print(object)
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
}
