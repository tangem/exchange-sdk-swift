//
//  NetworkFacade.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation
import Moya

class NetworkFacade {
    let debugMode: Bool
    
    // MARK: - Private variable
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private let provider = MoyaProvider<BaseTarget>()
    
    init(debugMode: Bool) {
        self.debugMode = debugMode
    }
    
    // MARK: - Internal methods
    
    func request<T: Decodable>(with target: BaseTarget, decodingObject: T.Type) async -> Result<T, ExchangeError> {
        let asyncRequestWrapper = AsyncMoyaRequestWrapper<T> { [weak self] continuation in
            guard let self = self else { return nil }
            
            return self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    if self.debugMode {
                        print("URL REQUEST -> \(response.request?.url?.absoluteString ?? "")")
                        self.responseDecoding(data: response.data, decodeTo: decodingObject)
                    }
                    guard let object = try? self.jsonDecoder.decode(decodingObject, from: response.data) else {
                        if let errorResponse = try? self.jsonDecoder.decode(ErrorDTO.self, from: response.data) {
                            continuation.resume(returning: .failure(.parsedError(withInfo: errorResponse)))
                        } else {
                            continuation.resume(returning: .failure(.unknownError(statusCode: response.statusCode)))
                        }
                        return
                    }
                    
                    continuation.resume(returning: .success(object))
                case .failure(let error):
                    if self.debugMode {
                        print("URL REQUEST -> \(error.response?.request?.url?.absoluteString ?? "")")
                    }
                    continuation.resume(returning: .failure(.serverError(withError: error)))
                }
            }
        }
        
        return await withTaskCancellationHandler(handler: {
            asyncRequestWrapper.cancel()
        }, operation: {
            await withCheckedContinuation({ continuation in
                asyncRequestWrapper.perform(continuation: continuation)
            })
        })
    }
    
    private func responseDecoding<T: Decodable>(data: Data, decodeTo: T.Type) {
        do {
            let decodeJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dataJSON = try JSONSerialization.data(withJSONObject: decodeJSON, options: .prettyPrinted)
            print(String(decoding: dataJSON, as: UTF8.self))
        } catch {
            print("Decoding response error -> \(error)")
        }
        
        do {
            _ = try jsonDecoder.decode(decodeTo, from: data)
            print("Decode to object success")
        } catch {
            print("Decode to object error -> \(error)")
        }
    }
}
