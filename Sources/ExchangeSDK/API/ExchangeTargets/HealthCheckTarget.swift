import Moya
import Foundation

enum HealthCheckTarget {
    case healthCheck(blockchain: ExchangeBlockchain)
}

extension HealthCheckTarget: TargetType {
    var baseURL: URL {
        ExchangeConstants.exchangeAPIBaseURL
    }
    
    var path: String {
        switch self {
        case .healthCheck(let exchangeBlockchain):
            return "/\(exchangeBlockchain.id)/healthcheck"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
