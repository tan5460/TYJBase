//
//  YJRootTabBarController.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/8.
//

import UIKit

class YJRootTabBarController: YJBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createViewControllers()
    }
    
    private func createViewControllers() {
        let homeNavi = YJBaseNavigationController(rootViewController: YJHomeViewController())
        let liveNavi = YJBaseNavigationController(rootViewController: YJLiveHomeViewController())
        let messageNavi = YJBaseNavigationController(rootViewController: YJMessageHomeViewController())
        let myNavi = YJBaseNavigationController(rootViewController: YJMyHomeViewController())
        viewControllers = [homeNavi, liveNavi, messageNavi, myNavi];
    }
    

}
