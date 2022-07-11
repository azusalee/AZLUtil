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
        
        let buildNum: String? = AZLInfoPlistUtil.getValue(keyName: .Common.buildNum)
        
        var contentString: String = ""
        
        contentString.append("设备型号: "+AZLDeviceUtil.deviceTypeName()+"\n")
        contentString.append("系统版本: "+AZLDeviceUtil.systemOSVersion()+"\n")
        contentString.append("ip地址: "+AZLDeviceUtil.ipAddress()+"\n")
        contentString.append("safeArea: "+"\(AZLDeviceUtil.safeAreaInset())"+"\n")
        contentString.append("默认导航栏高度: "+"\(AZLDeviceUtil.defaultNavBarHeight())"+"\n")
        contentString.append("默认状态栏高度: "+"\(AZLDeviceUtil.defaultStatusBarHeight())"+"\n")
        contentString.append("可用空间: "+"\(AZLDeviceUtil.freeDiskSize()) b"+"\n")
        contentString.append("cpu: "+"\(AZLDeviceUtil.cpuUsage())"+"\n")
        let mermoryTuble = AZLDeviceUtil.memoryUsage()
        contentString.append("内存: "+"\(mermoryTuble.used)"+"\n")
        
        contentString.append("home: "+"\(AZLFolderPath.Common.home.rawValue)"+"\n")
        contentString.append("document: "+"\(AZLFolderPath.Common.document.rawValue)"+"\n")
        contentString.append("tmp: "+"\(AZLFolderPath.Common.tmp.rawValue)"+"\n")
        contentString.append("libCache: "+"\(AZLFolderPath.Common.libCache.rawValue)"+"\n")
        contentString.append("libApplication: "+"\(AZLFolderPath.Common.libApplication.rawValue)"+"\n")
         
        
        self.textView.text = contentString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

