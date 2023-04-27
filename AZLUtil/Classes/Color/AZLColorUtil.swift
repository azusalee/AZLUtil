//
//  AZLColorUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2023/4/27.
//

import Foundation

/// 颜色工具类
/// 里面的argb的格式参考 0xffffffff，这个代表白色
public struct AZLColorUtil {
    private init() {}
    
    /// 获取lumiance值 亮度 算法1
//    static func getLuminance(argb: Int64) -> Float {
//        let r = Float((argb & 0xFF0000) >> 16)/255
//        let g = Float((argb & 0xFF00) >> 8)/255
//        let b = Float(argb & 0xFF)/255
//        let values = [r, g, b]
//        var results: [Float] = []
//        for value in values {
//            if value <= 0.03928 {
//                results.append(value/12.92)
//            } else {
//                results.append(powf((value+0.055)/1.055, 2.4))
//            }
//        }
//
//        return 0.2126 * results[0] + 0.7152 * results[1] + 0.0722 * results[2]
//    }
    
    /// 获取lumiance值 亮度 算法2
    ///
    /// - Parameter argb: 颜色值
    /// - Returns: 0~255 亮度值
    public static func getLuminance_2(argb: Int64) -> Float {
        let r = Float((argb & 0xFF0000) >> 16)
        let g = Float((argb & 0xFF00) >> 8)
        let b = Float(argb & 0xFF)
        
        return r*0.299 + g*0.587 + b*0.114
    }
    
    /// 是否亮色
    ///
    /// - Parameter argb: 颜色值
    /// - Returns: 是否亮色
    public static func isLightColor(argb: Int64) -> Bool {
        // 亮度大于一定值时认为是亮色
        //return self.getLuminance(argb: argb) >= 0.17912878475
        return self.getLuminance_2(argb: argb) >= 160
    }
    
    /// 判断多个颜色整体是否亮色
    ///
    /// - Parameter argbs: 多个颜色值
    /// - Returns: 是否亮色
    public static func isLightColor(argbs: [Int64]) -> Bool {
        if argbs.count == 0 {
            return false
        }
        // 亮度大于一定值时认为是亮色
        // 计算多个色的中间值
        var total: Float = 0
        for argb in argbs {
            total += self.getLuminance_2(argb: argb)
        }
        
        return total/Float(argbs.count) >= 160.0
    }
    
    /// 颜色变浅
    /// - Parameters:
    ///   - argb: argb颜色值
    ///   - rate: 取值[0, 1]，rate值越大，变得越浅，不要输入负数
    /// - Returns: 新的颜色值
    public static func lighenColor(argb: Int64, rate: Float = 0.55) -> Int64 {
        let a = (argb & 0xFF000000)
        let r = (argb & 0xFF0000) >> 16
        let g = (argb & 0xFF00) >> 8
        let b = argb & 0xFF
        
        let resultR = min(Int64(Float(255-r)*rate)+r, 255)
        let resultG = min(Int64(Float(255-g)*rate)+g, 255)
        let resultB = min(Int64(Float(255-b)*rate)+b, 255)
        
        return a+(resultR<<16)+(resultG<<8)+resultB
    }
    
    /// 颜色变深
    /// - Parameters:
    ///   - argb: argb颜色值
    ///   - rate: 取值[0, 1]，rate值越大，变得越深，不要输入负数
    /// - Returns: 新的颜色值
    public static func darkenColor(argb: Int64, rate: Float = 0.55) -> Int64 {
        let a = (argb & 0xFF000000)
        let r = (argb & 0xFF0000) >> 16
        let g = (argb & 0xFF00) >> 8
        let b = argb & 0xFF
        
        let resultR = max(Int64(Float(r)*(1-rate)), 0)
        let resultG = max(Int64(Float(g)*(1-rate)), 0)
        let resultB = max(Int64(Float(b)*(1-rate)), 0)
        
        return a+(resultR<<16)+(resultG<<8)+resultB
    }
}
