//
//  ViewController.swift
//  AZLUtil
//
//  Created by azusalee on 09/06/2021.
//  Copyright (c) 2021 azusalee. All rights reserved.
//

import UIKit
import AZLUtil

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var contentString: String = ""
        
        contentString.append("设备型号: "+AZLDeviceUtil.deviceTypeName()+"\n")
        contentString.append("系统版本: "+AZLDeviceUtil.systemOSVersion()+"\n")
        contentString.append("ip地址: "+AZLDeviceUtil.ipAddress()+"\n")
        contentString.append("safeArea: "+"\(AZLDeviceUtil.safeAreaInset())"+"\n")
        contentString.append("默认导航栏高度: "+"\(AZLDeviceUtil.defaultNavBarHeight())"+"\n")
        contentString.append("默认状态栏高度: "+"\(AZLDeviceUtil.defaultStatusBarHeight())"+"\n")
        contentString.append("应用名: "+"\(AZLDeviceUtil.infoPlistValue(keyType: .displayName) ?? "")"+"\n")
        contentString.append("bundle id: "+"\(AZLDeviceUtil.infoPlistValue(keyType: .bundleID) ?? "")"+"\n")
        contentString.append("version: "+"\(AZLDeviceUtil.infoPlistValue(keyType: .version) ?? "")"+"\n")
        contentString.append("build num: "+"\(AZLDeviceUtil.infoPlistValue(keyType: .buildNum) ?? "")"+"\n")
        contentString.append("可用空间: "+"\(AZLDeviceUtil.freeDiskSize()) b"+"\n")
        contentString.append("cpu: "+"\(AZLDeviceUtil.cpuUsage())"+"\n")
        let mermoryTuble = AZLDeviceUtil.memoryUsage()
        contentString.append("内存: "+"\(mermoryTuble.used)"+"\n")
        
        self.textView.text = contentString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

