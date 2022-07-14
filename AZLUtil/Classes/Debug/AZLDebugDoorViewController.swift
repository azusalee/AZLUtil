//
//  KSDebugDoorViewController.swift
//  AZLUtil
//
//  Created by lizihong on 2021/3/2.
//

import UIKit

/**
用于给debugwindow用的controller
 */
class AZLDebugDoorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AZLDebugManager.sharedInstance.hideDebug()
    }

}
