//
//  YJUserInfo.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/8.
//

import UIKit

class YJUserInfo: NSObject {
    
    static let shared = YJUserInfo()
    
    override private init() {}
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
}

extension YJUserInfo {
    
    var isLogin: Bool {
        return false
    }
}

extension YJUserInfo {
    
    func showLoginVC(present: Bool = false) {
        if present {
            UIApplication.shared.keyWindow?.rootViewController?.present(YJLoginViewController(), animated: true, completion: nil)
        } else {
            self.currentFrontVC?.navigationController?.pushViewController(YJLoginViewController(), animated: true)
        }
    }
    
}
