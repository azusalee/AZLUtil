//
//  AZLFileUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2021/10/9.
//

import UIKit

public protocol AZLFolderTypeProtocol {
    /// 文件夹路径
    func folderPath() -> String
}

/// 常用文件夹路径类型
public enum AZLRootFolderType: AZLFolderTypeProtocol {
    /// 根目录
    case home
    /// /Documents
    case document
    /// /tmp
    case tmp
    /// Library/Caches
    case libCache
    /// Library/Application
    case libApplication
    
    /// 文件夹路径
    public func folderPath() -> String {
        var rootPath = ""
        switch self {
        case .home:
            rootPath = NSHomeDirectory()
        case .document:
            rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        case .tmp:
            rootPath = NSTemporaryDirectory()
        case .libCache:
            rootPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        case .libApplication:
            rootPath = NSSearchPathForDirectoriesInDomains(.applicationDirectory, .userDomainMask, true)[0]
        }
        return rootPath
    }
}

public enum AZLFileType {
    case file
    case folder
    case notExist
}

public class AZLFileObject: NSObject {
    public var fullPath: String = ""
    public var name: String = ""
    public var type: AZLFileType = .notExist
    public var createDate: Date?
    public var modifyDate: Date?
    public var fileSize: Int = 0
    
    public var subPaths: [AZLFileObject] = []
    
}

public class AZLFileUtil: NSObject {
    
    /// 获取文件路径
    public class func getFilePath(folder: AZLFolderTypeProtocol, name: String) -> String {
        let folderPath = folder.folderPath()
        let filePath = folderPath+"/\(name)"
        return filePath
    }
    
    /// 写入数据
    public class func write(data: Data, folder: AZLFolderTypeProtocol, name: String) {
        let filePath = self.getFilePath(folder: folder, name: name)
        try? data.write(to: URL.init(fileURLWithPath: filePath))
    }
    
    /// 写入数据(路径需要自己拼接)
    public class func write(data: Data, fullPath: String) {
        try? data.write(to: URL.init(fileURLWithPath: fullPath))
    }
    
    /// 读取数据
    public class func readData(folder: AZLFolderTypeProtocol, name: String) -> Data? {
        let filePath = self.getFilePath(folder: folder, name: name)
        let data = try? Data(contentsOf: URL.init(fileURLWithPath: filePath))
        return data
    }
    
    /// 读取数据(路径需要自己拼接)
    public class func readData(fullPath: String) -> Data? {
        let data = try? Data(contentsOf: URL.init(fileURLWithPath: fullPath))
        return data
    }
    
    /// 删除文件
    public class func delete(folder: AZLFolderTypeProtocol, name: String) {
        let filePath = self.getFilePath(folder: folder, name: name)
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: filePath)
    }
    
    /// 删除文件(路径需要自己拼接)
    public class func delete(fullPath: String) {
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: fullPath)
    }
    
    /// 检测文件类型
    public class func checkFileType(path: String) -> AZLFileType {
        var isDir: ObjCBool = false
        let isExist = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        if isExist {
            return .notExist
        }
        if isDir.boolValue == true {
            return .folder
        }
        return .file
    }
    
    /// 创建文件夹
    public class func createFolder(path: String) -> String {
        try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        
        return path
    }
    
    /// 获取文件对象
    public class func fileObject(path: String) -> AZLFileObject? {
        let fileManager = FileManager.default
        let fileType = self.checkFileType(path: path)
        
        if fileType != .notExist {
            let fileObject = AZLFileObject()
            let fileName = path.components(separatedBy: "/").last
            fileObject.name = fileName ?? ""
            fileObject.fullPath = path
            fileObject.type = fileType
            if let fileAttr = try? fileManager.attributesOfItem(atPath: path) {
                fileObject.createDate = fileAttr[.creationDate] as? Date
                fileObject.modifyDate = fileAttr[.modificationDate] as? Date
                fileObject.fileSize = fileAttr[.size] as? Int ?? 0
            }
            if fileType == .folder {
                if let pathNameArray = try? fileManager.contentsOfDirectory(atPath: path) {
                    for pathName in pathNameArray {
                        let subPath = path+"/"+pathName
                        if let subObject = self.fileObject(path: subPath) {
                            fileObject.subPaths.append(subObject)
                        }
                    }
                }
            }
            
            return fileObject
        } else {
            return nil
        }
    }
    
}
