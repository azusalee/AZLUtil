//
//  AZLInfoPlistUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2022/7/11.
//

import Foundation

/// infoplist的key值
public struct AZLPlistKey {
    
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension AZLPlistKey {
    /// infoplist常用key
    public struct Common {
        /// bundle id
        public static let bundleID = AZLPlistKey.init(rawValue: "CFBundleIdentifier")
        /// 名字
        public static let displayName = AZLPlistKey.init(rawValue: "CFBundleDisplayName")
        /// 发布版本
        public static let version = AZLPlistKey.init(rawValue: "CFBundleShortVersionString")
        /// build号
        public static let buildNum = AZLPlistKey.init(rawValue: "CFBundleVersion")
    }
}

/**
获取plist内容的工具类
 */
public class AZLInfoPlistUtil {
    
    /// 获取info.plist的数据
    /// 
    /// - Parameter keyName: plist的key
    /// - Returns: 对应的值
    public static func getValue<T: Any>(keyName: AZLPlistKey) -> T? {
        let dict = Bundle.main.infoDictionary
        return dict?[keyName.rawValue] as? T
    }
}
