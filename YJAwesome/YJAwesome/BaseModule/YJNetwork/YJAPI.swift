//
//  YJNetworkAPI.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/2.
//

import Foundation
import Moya
import AdSupport
import CoreTelephony


enum YJAPI {
    ///首页推荐拍品接口
    case system_unauth_home_recommend
    
}

extension YJAPI: TargetType {

    var baseURL: URL {
        return URL(string: "http://192.168.1.240:20001/")!
    }

    var path: String {
        switch self {
        case .system_unauth_home_recommend:
            return "system/unauth/home/recommend"
        default:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .system_unauth_home_recommend:
            return .requestParameters(parameters: getRequestParam(msg: nil), encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
        
        
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    private func getRequestParam(msg: [String : Any]?) -> [String : Any] {
        var param = [String : Any]()
        //客户端类型号
        let src = "3"
        param["src"] = Int(src)
        //版本号
        param["ver"] = kAppVersion
        //IDFA
        param["deviceIds"] = ["IDFA" : ASIdentifierManager.shared().advertisingIdentifier.uuidString]
        //时区
        var timezone = NSTimeZone.system.abbreviation() ?? ""
        if timezone.contains("GMT") {
            timezone = String(timezone[..<timezone.index(timezone.endIndex, offsetBy: -3)])
        }
        param["timezone"] = 0
        //时间戳
        let date = Int(Date().timeIntervalSince1970*1000)
        param["timestamp"] = String(date)
        //MD5
        let md5Key = "DivJ6a5Gf@M0wxa5"
        let unMd5String = src + String(date) + md5Key
        param["md5"] = unMd5String.md5
        //
//        param["deviceInfo"] = 0
        //
//        param["userId"] = 0
        //
//        param["snapshot"] = 0
        //运营商信息
        var carrierName = " "
        var carrierCountryCode = " "
        var carrierNetworkCode = ""
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.forEach({ (key: String, value: CTCarrier) in
            if let name = value.carrierName {
                carrierName = name
            }
            if let countryCode = value.mobileCountryCode {
                carrierCountryCode = countryCode
            }
            if let networkCode = value.mobileNetworkCode {
                carrierNetworkCode = networkCode
            }
        })
        param["carrier"] = ["name" : carrierName, "code" : carrierCountryCode + carrierNetworkCode]
        
        
        //接口参数
        if let msg = msg {
            param["msg"] = msg
        }
        
        return param
    }
    
}



   


