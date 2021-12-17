//
//  YJConst.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/6.
//

import Foundation


let kAPPInfo = Bundle.main.infoDictionary ?? [String : Any]()
///APP名称
let kAppName = kAPPInfo["CFBundleDisplayName"] ?? ""
///APP版本号
let kAppVersion = kAPPInfo["CFBundleShortVersionString"] ?? ""
///APPBuild号
let kAppBuildVersion = kAPPInfo["CFBundleVersion"] ?? ""
