//
//  YJExtension.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/6.
//

import CommonCrypto
import UIKit

public extension UIApplication {
    var keyWindow: UIWindow? {
        self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }.first?.windows
            .filter { $0.isKeyWindow }.first
    }
}

public extension NSObject {
    
    var currentFrontVC: UIViewController? {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            return findFrontVC(fromVC: rootVC)
        }
        return nil
    }
    
    private func findFrontVC(fromVC: UIViewController) -> UIViewController {
        
        if let presentVC = fromVC.presentedViewController {
            return findFrontVC(fromVC: presentVC)
        }
        
        if let tabBarVC = fromVC as? UITabBarController, let selectedVC = tabBarVC.selectedViewController {
            return findFrontVC(fromVC: selectedVC)
        }
        
        if let naviVC = fromVC as? UINavigationController, let naviTopVC = naviVC.topViewController {
            return findFrontVC(fromVC: naviTopVC)
        }
        return fromVC
    }
}

public extension String {
    
    var md5: String {
        let cString = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cString, CC_LONG(cString!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format: "%02x", $1)}
    }
    
    
    
}


public extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = hex & 0xFF0000 / 0xFFFF
        let g = hex & 0xFF00 / 0xFF
        let b = hex & 0xFF
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}


