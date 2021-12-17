//
//  YJActionCaptcha.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/13.
//

import Foundation
import SwiftyRSA

let captchaKey = "IjAN7MIIBghkiGuBgkqdAQEFc9w0BiAQ8AIAAOCZCgKCmMIIBvou2LvAQEATMKygdnz67LrMBWMGzB9imiNiyqleuqWN2QdLLIVj7XKvKy+z/j/oOVs+tOg4LebF+erkoram3F92AtFBrJOQHKN9l8ovWaRQ2ICoSSnxJYboU/uxnpbhOvFWn0iQPqnrFyTnSiV/IaJsHa/z8O4XRcsrgQeg0/ToXuH0EZ0BbdUwwqXwbt3u/5sL/6Hyz/Q2sUuHfgo92fEydjy+NwljgWLO9dO6sedzv915i3pIe5kuQcXrh/dsBVca+XfyvD3kkf/YIAsJZNLUSbgkL+V4q3WJ0cL1eLNMuEc8hSTS6kY+d5qGpDfS432vqqTSLLfXJGcy39OG63TnFlgGhkD4Y5PGWA/xl6Qk5hYDJy8nwSgBOhXV0b5dyl6/ZmWDhLbg2u17xjm+PWEsS/er6qCicWnizw28oDiXNBn7AQAB9gwID8"

class YJActionCaptcha: NSObject {
    
    func start() {
        let timeStamp = String(Int(NSDate().timeIntervalSince1970 * 1000))
        let uid = "0"
        let dataString = "3" + "," + timeStamp + "," + uid + "," + "" + "," + "user/phoneloginwithsms"
        
        var pubKey = captchaKey
        var pubString = ""
        while pubKey.count >= 10 {
            let string1 = String(pubKey[pubKey.startIndex...pubKey.index(pubKey.startIndex, offsetBy: 3)])
            let string2 = String(pubKey[pubKey.index(pubKey.startIndex, offsetBy: 5)...pubKey.index(pubKey.index(pubKey.startIndex, offsetBy: 5), offsetBy: 3)])
            pubString.append(string2)
            pubString.append(string1)
            pubKey.removeSubrange(pubKey.startIndex...pubKey.index(pubKey.startIndex, offsetBy: 9))
        }
        pubString.append(pubKey)
        pubString.replacingOccurrences(of: " ", with: "")
        
    }
    
}

