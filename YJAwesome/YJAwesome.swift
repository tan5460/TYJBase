//
//  File.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/1.
//

import Foundation

import Alamofire
import Moya



//MARK: - UI
let kIPhoneX = (kScreenHeight > 812)

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kScaleWidth = (kScreenWidth/375.0)
let kScaleHeight = (kScreenHeight/667.0)

let kStatusBarHeight = kIPhoneX ? 44 : 20
let kNaviBarHeight = kStatusBarHeight + 44
let kTabBarHeight = CGFloat(kIPhoneX ? 83.0 : 49.0)
let kBottomSafeHeight = CGFloat(kIPhoneX ? 34.0 : 0.0)
