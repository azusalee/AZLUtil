//
//  AZLFolderPath.swift
//  AZLUtil
//
//  Created by lizihong on 2022/7/11.
//

import Foundation

/// 文件夹路径
public struct AZLFolderPath {
    // 路径的字符串
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension AZLFolderPath {
    /// 常用文件夹路径类型
    public struct Common {
        /// 根目录
        public static let home = AZLFolderPath.init(rawValue: NSHomeDirectory())
        /// /Documents
        public static let document = AZLFolderPath.init(rawValue: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        /// /tmp
        public static let tmp = AZLFolderPath.init(rawValue: NSTemporaryDirectory())
        /// /Library/Caches
        public static let libCache = AZLFolderPath.init(rawValue: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])
        /// /Application
        public static let libApplication = AZLFolderPath.init(rawValue: NSSearchPathForDirectoriesInDomains(.applicationDirectory, .userDomainMask, true)[0])
    }
}
