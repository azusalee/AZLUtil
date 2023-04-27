//
//  AZLFile.swift
//  AZLUtil
//
//  Created by lizihong on 2022/7/11.
//

import Foundation

/**
文件对象
 */
public class AZLFile {
    /// 文件路径类型
    public enum FilePathType {
        /// 文件
        case file
        /// 文件夹
        case folder
        /// 不存在
        case notExist
    }
    
    /// 完整路径
    public var fullPath: String = ""
    /// 文件名
    public var name: String = ""
    /// 文件类型
    public var type: FilePathType = .notExist
    /// 创建日期
    public var createDate: Date?
    /// 修改日期
    public var modifyDate: Date?
    /// 文件大小
    public var fileSize: Int = 0
}
