//
//  KSDebugDoorView.swift
//  AZLUtil
//
//  Created by lizihong on 2021/3/2.
//

import UIKit

/**
用于debug的window
 */
class AZLDebugDoorWindow: UIWindow {
    
    // 入口的宽度
    private static let DoorSize: CGFloat = 50.0
    // debug 的入口按钮
    var doorButton: UIButton?
    
    private var panGesture: UIPanGestureRecognizer?
    
    var lastOrigin: CGPoint = CGPoint.init(x: 0, y: 0)
    
    /// 创建默认位置的debug window
    class func createDefaultWindow() -> AZLDebugDoorWindow {
        return AZLDebugDoorWindow.init(frame: CGRect.init(origin: CGPoint.init(x: 15, y: 44), size: CGSize.init(width: DoorSize, height: DoorSize)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        self.lastOrigin = self.frame.origin
        self.rootViewController = AZLDebugDoorViewController()
        self.backgroundColor = .clear
        self.windowLevel = .statusBar+100
        self.layer.masksToBounds = true
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: AZLDebugDoorWindow.DoorSize, height: AZLDebugDoorWindow.DoorSize))
        button.layer.cornerRadius = button.bounds.size.height/2
        button.setTitle("Debug", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.33)
        button.addTarget(self, action: #selector(doorDidTap(_:)), for: .touchUpInside)
        self.doorButton = button
        self.rootViewController?.view.addSubview(button)
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(viewDidPan(gesture:)))
        self.addGestureRecognizer(panGesture)
        self.panGesture = panGesture
        
    }
    
    /// 拖动手势处理，调整拖动后，入口的位置，防止停留在难以点击的位置
    @objc
    func viewDidPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            let tranlate = gesture.translation(in: self)
            gesture.setTranslation(CGPoint.zero, in: self)
            self.center = CGPoint.init(x: self.center.x+tranlate.x, y: self.center.y+tranlate.y)
        case .ended, .cancelled:
            let doorSize = AZLDebugDoorWindow.DoorSize
            // 边缘位置
            let inset = UIEdgeInsets.init(top: doorSize/2+44, left: doorSize/2+15, bottom: UIScreen.main.bounds.size.height-doorSize/2-44, right: UIScreen.main.bounds.size.width-doorSize/2-15)
        
            var position = self.center
            
            // 让入口在屏幕边缘
            let top = position.y-inset.top
            let bottom = inset.bottom-position.y
            let left = position.x-inset.left
            let right = inset.right-position.x
            // 离哪个近就往那边靠
            if top < bottom && top < left && top < right {
                position.y = inset.top
            } else if bottom < top && bottom < left && bottom < right {
                position.y = inset.bottom
            } else if left < top && left < bottom && left < right {
                position.x = inset.left
            } else {
                position.x = inset.right
            }
            
            // 让入口不超出边缘
            if position.x < inset.left {
                position.x = inset.left
            } else if position.x > inset.right {
                position.x = inset.right
            }
            
            if position.y < inset.top {
                position.y = inset.top
            } else if position.y > inset.bottom {
                position.y = inset.bottom
            }
            
            UIView.animate(withDuration: 0.275) { 
                self.center = position
            }
        default:
            break
        }
    }
    
    /// 入口被点击
    @objc
    func doorDidTap(_ sender: UIButton) {
        self.lastOrigin = self.frame.origin
        
        let rootVC = self.rootViewController
        let controller = AZLDebugListViewController()
        controller.cellModels = AZLDebugManager.sharedInstance.customDebugCellModel
        let navVC = UINavigationController.init(rootViewController: controller)
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .crossDissolve
        rootVC?.present(navVC, animated: true, completion: nil)
        
        self.showView()
    }
    
    /// 展开显示
    func showView() {
        UIView.animate(withDuration: 0.275) { 
            self.doorButton?.alpha = 0
            self.frame = UIScreen.main.bounds
        }
        self.panGesture?.isEnabled = false
    }
    
    /// 收起显示
    func hideView() {
        UIView.animate(withDuration: 0.275) { 
            self.doorButton?.alpha = 1
            self.frame = CGRect.init(origin: self.lastOrigin, size: CGSize.init(width: AZLDebugDoorWindow.DoorSize, height: AZLDebugDoorWindow.DoorSize))
        }
        self.panGesture?.isEnabled = true
    }
    
}
