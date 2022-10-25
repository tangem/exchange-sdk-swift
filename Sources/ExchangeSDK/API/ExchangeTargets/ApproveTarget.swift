import Foundation
import Moya

enum InchApprove {
    case spender(blockchain: ExchangeBlockchain)
    case transaction(blockchain: ExchangeBlockchain, params: ApproveTransactionParameters)
    case allowance(blockchain: ExchangeBlockchain, params: ApproveAllowanceParameters)
}

extension InchApprove: TargetType {
    var baseURL: URL {
        ExchangeConstants.exchangeAPIBaseURL
    }
    
    var path: String {
        switch self {
        case .spender(let blockchain):
            return "/\(blockchain.id)/approve/spender"
        case .transaction(let blockchain, _):
            return "/\(blockchain.id)/approve/transaction"
        case .allowance(let blockchain, _):
            return "/\(blockchain.id)/approve/allowance"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        switch self {
        case .spender:
            return .requestPlain
        case .transaction(_, let params):
            return .requestParameters(parameters: params.parameters(), encoding: URLEncoding())
        case .allowance(_, let params):
            return .requestParameters(parameters: params.parameters(), encoding: URLEncoding())
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
