//
//  KSDebugManager.swift
//  AZLUtil
//
//  Created by lizihong on 2021/3/2.
//

import UIKit
import CoreMotion

/**
debug 管理器

控制debug入口显示隐藏
 */
public class AZLDebugManager: NSObject {
    
    public static let sharedInstance = AZLDebugManager()
    /// 用于显示debug入口的window
    var debugWindow: AZLDebugDoorWindow?
    
    var motionManager: CMMotionManager?
    var lastAcceleration: CMAcceleration?
    
    /// 自定义debug入口，用于debug列表显示
    public var customDebugCellModel: [AZLDebugListCellModel] = []
    
    /// 是否已经初始化入口了
    private var isInstall: Bool = false
    
    /// 添加debug入口，创建debug窗口
    public func install() {
        if self.isInstall == true {
            return
        }
        self.isInstall = true
        let debugDoor = AZLDebugDoorWindow.createDefaultWindow()
        debugDoor.isHidden = false
        
        self.debugWindow = debugDoor
    }
    
    /// 添加摇一摇手势显示debug入口
    public func setupMotionControl() {
        let manager = CMMotionManager.init()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (accData, error) in
            if let acceleration = accData?.acceleration {
                if let lastAcceleration = self?.lastAcceleration {
                    let power = fabs(acceleration.x-lastAcceleration.x)
                    // 摇动速度达到一定值以上时，显示debug入口
                    if power > 1 {
                        self?.install()
                    }
                }
                self?.lastAcceleration = acceleration
            }
        }
        
        self.motionManager = manager
    }
    
    /// 展开debug入口
    func showDebug() {
        self.debugWindow?.showView()
    }
    
    /// 收起debug入口
    func hideDebug() {
        self.debugWindow?.hideView()
    }
    
    /// 展示debug列表(这里不使用悬浮窗)
    public func showDebugList() {
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            let controller = AZLDebugListViewController()
            controller.cellModels = self.customDebugCellModel
            let navVC = UINavigationController.init(rootViewController: controller)
            navVC.modalPresentationStyle = .fullScreen
            rootVC.present(navVC, animated: true, completion: nil)
        }
    }

}
