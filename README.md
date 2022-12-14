# Exchange

Network layer for 1inch router.

```swift
let exchangeService: ExchangeServiceProtocol = ExchangeSdk.buildOneInchExchangeService(debugMode: true)

// Get tokens list
Task { 
    let tokens = await exchangeService.tokens(blockchain: .polygon)
    switch tokens {
    case .success(let tokensDTO):
        dto.tokens.forEach {
            print($0.value)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Generation swap data
Task { 
    let amount = 1_000_000_000_000_000_000
    let fromAddress = "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    let toAddress = "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063"
    let walletAddress = "0x**..." //Your wallet address
    
    let response = await exchangeService.swap(blockchain: .polygon,
                                       parameters: SwapParameters(fromTokenAddress: fromAddress,
                                                                  toTokenAddress: toAddress,
                                                                  amount: "\(amount)",
                                                                  fromAddress: walletAddress,
                                                                  slippage: 1))
    switch response {
    case .success(let dto):
        print(dto.tx.data) // Data for send to blockchain
    case .failure(let error):
        print(error)
    }
}
```

Supports **Ethereum**, **Binance smart chain**, **Polygon**, **Optimism**, **Arbitrum**, **Gnosis**, **Avalanche**, **Fantom**, **Klayth**, **Aurora**.
