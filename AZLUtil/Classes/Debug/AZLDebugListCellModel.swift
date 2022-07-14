//
//  KSDebugListCellModel.swift
//  AZLUtil
//
//  Created by lizihong on 2022/7/14.
//  Copyright © 2022 BT. All rights reserved.
//

import Foundation

/**
debug列表用的cellModel
 */
public class AZLDebugListCellModel: NSObject {
    /// 标题
    public var title: String = ""
    /// 点击后，要跳到的controller
    public var vcType: UIViewController.Type?
    
    /// 自定义点击操作，这个设置后vcType将无效
    public var actionBlock: (() -> Void)?
    
    /// 创建对象
    public init(title: String, vcType: UIViewController.Type?, actionBlock: (() -> Void)?) {
        super.init()
        self.title = title
        self.vcType = vcType
        self.actionBlock = actionBlock
    }
}
