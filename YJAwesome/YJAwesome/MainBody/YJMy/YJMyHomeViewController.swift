//
//  YJMyHomeViewController.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/8.
//

import UIKit
import SnapKit

class YJMyHomeViewController: YJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginBtn = UIButton(type: .custom)
        loginBtn.backgroundColor = .lightGray
        loginBtn.setTitle(YJUserInfo.shared.isLogin ? "退出登录" : "登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.center.equalTo(view)
        }
    }
    
    
    @objc func loginBtnAction(sender: UIButton) {
        if YJUserInfo.shared.isLogin {
            
        } else {
            YJUserInfo.shared.showLoginVC()
        }
    }

}
