//
//  YJNetworking.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/6.
//

import Foundation
import Moya

typealias successClosure = (([String : Any]?) -> Void)
typealias failureClosure = ((Int, String) -> Void)?

let endpointClosure = { (target: YJAPI) -> Endpoint in
    let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    
    
    return endpoint
}

let networkProvider = MoyaProvider(endpointClosure: endpointClosure)


func YJNetworkRequst(_ param: YJAPI, success: @escaping successClosure, failure: failureClosure = nil) {
    networkProvider.request(param) { result in
        switch result {
        case let .success(response):
            if let responseObject = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? [String : Any] {
                success(responseObject)
            } else {
                failure?(-1, "数据异常")
            }
        case let .failure(error):
            let code = error.errorCode
            let desc = error.localizedDescription
            failure?(code, desc)
        }
    }
}
