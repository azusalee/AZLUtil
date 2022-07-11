//
//  AZLFileUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2021/10/9.
//

import Foundation

/**
文件操作工具类
 */
public class AZLFileUtil {
    
    /// 获取文件路径
    /// 
    /// - Parameters:
    ///   - folder: 文件夹
    ///   - name: 文件名
    /// - Returns: 完整路径
    public class func getFilePath(folder: AZLFolderPath, name: String) -> String {
        let folderPath = folder.rawValue
        let filePath = folderPath+"/\(name)"
        return filePath
    }
    
    /// 写入数据
    /// 
    /// - Parameters:
    ///   - data: 数据
    ///   - folder: 文件夹
    ///   - name: 文件名
    public class func write(data: Data, folder: AZLFolderPath, name: String) {
        let filePath = self.getFilePath(folder: folder, name: name)
        self.write(data: data, fullPath: filePath)
    }
    
    /// 写入数据(路径需要自己拼接)
    /// 
    /// - Parameters:
    ///   - data: 数据
    ///   - fullPath: 完整路径
    public class func write(data: Data, fullPath: String) {
        try? data.write(to: URL.init(fileURLWithPath: fullPath), options: [.atomic])
    }
    
    /// 读取数据
    /// 
    /// - Parameters:
    ///   - folder: 文件夹
    ///   - name: 文件名
    /// - Returns: 文件数据
    public class func readData(folder: AZLFolderPath, name: String) -> Data? {
        let filePath = self.getFilePath(folder: folder, name: name)
        let data = self.readData(fullPath: filePath)
        return data
    }
    
    /// 读取数据(路径需要自己拼接)
    /// 
    /// - Parameter fullPath: 完整路径
    /// - Returns: 文件数据
    public class func readData(fullPath: String) -> Data? {
        let data = try? Data(contentsOf: URL.init(fileURLWithPath: fullPath))
        return data
    }
    
    /// 删除文件
    /// 
    /// - Parameters:
    ///   - folder: 文件夹
    ///   - name: 文件名
    public class func delete(folder: AZLFolderPath, name: String) {
        let filePath = self.getFilePath(folder: folder, name: name)
        self.delete(fullPath: filePath)
    }
    
    /// 删除文件夹
    /// 
    /// - Parameter folder: 文件夹
    public class func delete(folder: AZLFolderPath) {
        let filePath = folder.rawValue
        self.delete(fullPath: filePath)
    }
    
    /// 删除文件(路径需要自己拼接)
    /// 
    /// - Parameter fullPath: 完整路径
    public class func delete(fullPath: String) {
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: fullPath)
    }
    
    /// 检测文件类型
    /// 
    /// - Parameter path: 文件路径
    /// - Returns: 文件类型
    public class func checkFileType(path: String) -> AZLFile.FileType {
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
    /// 
    /// - Parameter path: 完整路径
    public class func createFolder(path: String) {
        try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// 获取文件对象
    /// 
    /// - Parameter path: 文件路径
    /// - Returns: 文件对象
    public class func fileObject(path: String) -> AZLFile? {
        let fileManager = FileManager.default
        let fileType = self.checkFileType(path: path)
        
        if fileType != .notExist {
            let fileObject = AZLFile()
            let fileName = path.components(separatedBy: "/").last
            fileObject.name = fileName ?? ""
            fileObject.fullPath = path
            fileObject.type = fileType
            if let fileAttr = try? fileManager.attributesOfItem(atPath: path) {
                fileObject.createDate = fileAttr[.creationDate] as? Date
                fileObject.modifyDate = fileAttr[.modificationDate] as? Date
                fileObject.fileSize = fileAttr[.size] as? Int ?? 0
            }
            
            return fileObject
        }
        return nil
    }
    
    /// 获取文件夹下子文件/文件夹
    /// - Parameter folderPath: 文件夹路径
    /// - Returns: 文件对象数组
    public class func getSubFiles(folderPath: String) -> [AZLFile] {
        let fileManager = FileManager.default
        var subFiles: [AZLFile] = []
        if let pathNameArray = try? fileManager.contentsOfDirectory(atPath: folderPath) {
            for pathName in pathNameArray {
                let subPath = folderPath+"/"+pathName
                if let subObject = self.fileObject(path: subPath) {
                    subFiles.append(subObject)
                }
            }
        }
        return subFiles
    }
    
}
