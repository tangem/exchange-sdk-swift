//
//  NetworkFacade.swift
//  Tangem
//
//  Created by Pavel Grechikhin.
//  Copyright © 2022 Tangem AG. All rights reserved.
//

import Foundation
import Moya

class NetworkService {
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
    
    func req<T: Decodable>(with target: BaseTarget) async -> Result<T, ExchangeInchError> {
        return await withCheckedContinuation({ _ in
            
        })
    }
    
    func request<T: Decodable>(with target: BaseTarget, decodingObject: T.Type) async -> Result<T, ExchangeInchError> {
        let asyncRequestWrapper = AsyncMoyaRequestWrapper<T> { [weak self] continuation in
            guard let self = self else { return nil }
            
            return self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    if self.debugMode {
                        print("URL REQUEST -> \(response.request?.url?.absoluteString ?? "")")
                        self.responseDecoding(data: response.data, decodeTo: decodingObject)
                    }
                    
                    if let response = try? response.filterSuccessfulStatusCodes() {
                        do {
                            let object = try self.jsonDecoder.decode(T.self, from: response.data)
                            continuation.resume(returning: .success(object))
                        } catch {
                            continuation.resume(returning: .failure(.decodeError(error: error)))
                        }
                    } else {
                        do {
                            let errorObject = try self.jsonDecoder.decode(InchError.self, from: response.data)
                            continuation.resume(returning: .failure(.parsedError(withInfo: errorObject)))
                        } catch {
                            continuation.resume(returning: .failure(.unknownError(statusCode: response.statusCode)))
                        }
                    }
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
    
    // MARK: - Private
    
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
