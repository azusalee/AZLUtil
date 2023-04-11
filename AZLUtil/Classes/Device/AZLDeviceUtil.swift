//
//  AZLDeviceUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2021/9/6.
//

import UIKit

/**
获取设备信息工具类

设备系统版本，设备类型，cpu使用率，内存等
 */
public class AZLDeviceUtil {
    /// 设备类型缓存值
    static var deviceTypeNameCache = ""
    
    /// 获取设备类型 (如果出新设备，需要手动更新这里)
    public static func deviceTypeName() -> String {
        if deviceTypeNameCache.count > 0 {
            return deviceTypeNameCache
        }
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        
        //iPhone
        if platform == "iPhone14,7" {deviceTypeNameCache = "iPhone 14"}
        else if platform == "iPhone14,8" {deviceTypeNameCache = "iPhone 14 Plus"}
        else if platform == "iPhone15,2" {deviceTypeNameCache = "iPhone 14 Pro"}
        else if platform == "iPhone15,3" {deviceTypeNameCache = "iPhone 14 Pro Max"}
        else if platform == "iPhone14,2" {deviceTypeNameCache = "iPhone 13 Pro"}
        else if platform == "iPhone14,3" {deviceTypeNameCache = "iPhone 13 Pro Max"}
        else if platform == "iPhone14,4" {deviceTypeNameCache = "iPhone 13 mini"}
        else if platform == "iPhone14,5" {deviceTypeNameCache = "iPhone 13"}
        else if platform == "iPhone13,1" {deviceTypeNameCache = "iPhone 12 mini"}
        else if platform == "iPhone13,2" {deviceTypeNameCache = "iPhone 12"}
        else if platform == "iPhone13,3" {deviceTypeNameCache = "iPhone 12 Pro"}
        else if platform == "iPhone13,4" {deviceTypeNameCache = "iPhone 12 Pro Max"}
        else if platform == "iPhone12,1" {deviceTypeNameCache = "iPhone 11"}
        else if platform == "iPhone12,3" {deviceTypeNameCache = "iPhone 11 Pro"}
        else if platform == "iPhone12,5" {deviceTypeNameCache = "iPhone 11 Pro Max"}
        else if platform == "iPhone12,8" {deviceTypeNameCache = "iPhone SE (2nd generation)"}
        else if platform == "iPhone11,8" {deviceTypeNameCache = "iPhone XR"}
        else if platform == "iPhone11,6" {deviceTypeNameCache = "iPhone XS Max"}
        else if platform == "iPhone11,4" {deviceTypeNameCache = "iPhone XS Max"}
        else if platform == "iPhone11,2" {deviceTypeNameCache = "iPhone XS"}
        else if platform == "iPhone10,6" {deviceTypeNameCache = "iPhone X"}
        else if platform == "iPhone10,5" {deviceTypeNameCache = "iPhone 8 Plus"}
        else if platform == "iPhone10,4" {deviceTypeNameCache = "iPhone 8"}
        else if platform == "iPhone10,3" {deviceTypeNameCache = "iPhone X"}
        else if platform == "iPhone10,2" {deviceTypeNameCache = "iPhone 8 Plus"}
        else if platform == "iPhone10,1" {deviceTypeNameCache = "iPhone 8"}
        else if platform == "iPhone9,4" {deviceTypeNameCache = "iPhone 7 Plus"}
        else if platform == "iPhone9,3" {deviceTypeNameCache =  "iPhone 7"}
        else if platform == "iPhone9,2" {deviceTypeNameCache =  "iPhone 7 Plus"}
        else if platform == "iPhone9,1" {deviceTypeNameCache =  "iPhone 7"}
        else if platform == "iPhone8,4" {deviceTypeNameCache =  "iPhone SE"}
        else if platform == "iPhone8,2" {deviceTypeNameCache =  "iPhone 6S Plus"}
        else if platform == "iPhone8,1" {deviceTypeNameCache =  "iPhone 6S"}
        else if platform == "iPhone7,2" {deviceTypeNameCache =  "iPhone 6"}
        else if platform == "iPhone7,1" {deviceTypeNameCache =  "iPhone 6 Plus"}
        else if platform == "iPhone6,2" {deviceTypeNameCache =  "iPhone 5S"}
        else if platform == "iPhone6,1" {deviceTypeNameCache =  "iPhone 5S"}
        else if platform == "iPhone5,4" {deviceTypeNameCache =  "iPhone 5C"}
        else if platform == "iPhone5,3" {deviceTypeNameCache =  "iPhone 5C"}
        else if platform == "iPhone5,2" {deviceTypeNameCache =  "iPhone 5"}
        else if platform == "iPhone5,1" {deviceTypeNameCache =  "iPhone 5"}
        else if platform == "iPhone4,1" {deviceTypeNameCache =  "iPhone 4S"}
        else if platform == "iPhone3,3" {deviceTypeNameCache =  "iPhone 4"}
        else if platform == "iPhone3,2" {deviceTypeNameCache =  "iPhone 4"}
        else if platform == "iPhone3,1" {deviceTypeNameCache =  "iPhone 4"}
        else if platform == "iPhone2,1" {deviceTypeNameCache =  "iPhone 3GS"}
        else if platform == "iPhone1,2" {deviceTypeNameCache =  "iPhone 3G"}
        else if platform == "iPhone1,1" {deviceTypeNameCache =  "iPhone 2G"}
        // iPod
        else if platform == "iPod9,1" {deviceTypeNameCache =  "iPod Touch 7"}
        else if platform == "iPod7,1" {deviceTypeNameCache =  "iPod Touch 6"}
        else if platform == "iPod5,1" {deviceTypeNameCache =  "iPod Touch 5"}
        else if platform == "iPod4,1" {deviceTypeNameCache =  "iPod Touch 4"}
        else if platform == "iPod3,1" {deviceTypeNameCache =  "iPod Touch 3"}
        else if platform == "iPod2,1" {deviceTypeNameCache =  "iPod Touch 2"}
        else if platform == "iPod1,1" {deviceTypeNameCache =  "iPod Touch 1"}
        //iPad
        else if platform == "iPad12,2" {deviceTypeNameCache =  "iPad 9"}
        else if platform == "iPad12,1" {deviceTypeNameCache =  "iPad 9"}
        else if platform == "iPad11,7" {deviceTypeNameCache =  "iPad 8"}
        else if platform == "iPad11,6" {deviceTypeNameCache =  "iPad 8"}
        else if platform == "iPad7,11" {deviceTypeNameCache =  "iPad 7"}
        else if platform == "iPad7,12" {deviceTypeNameCache =  "iPad 7"}
        else if platform == "iPad8,1" {deviceTypeNameCache =  "iPad Pro 11-inch"}
        else if platform == "iPad7,6" {deviceTypeNameCache =  "iPad 6 (Cellular)"}
        else if platform == "iPad7,5" {deviceTypeNameCache =  "iPad 6 (WiFi)"}
        else if platform == "iPad7,4" {deviceTypeNameCache =  "iPad Pro 10.5-inch (Cellular)"}
        else if platform == "iPad7,3" {deviceTypeNameCache =  "iPad Pro 10.5-inch (WiFi)"}
        else if platform == "iPad7,2" {deviceTypeNameCache =  "iPad Pro 12.9-inch 2nd-gen (Cellular)"}
        else if platform == "iPad7,1" {deviceTypeNameCache =  "iPad Pro 12.9-inch 2nd-gen (WiFi)"}
        else if platform == "iPad6,8" {deviceTypeNameCache =  "iPad Pro 12.9"}
        else if platform == "iPad6,7" {deviceTypeNameCache =  "iPad Pro 12.9"}
        else if platform == "iPad6,4" {deviceTypeNameCache =  "iPad Pro 9.7"}
        else if platform == "iPad6,3" {deviceTypeNameCache =  "iPad Pro 9.7"}
        else if platform == "iPad5,4" {deviceTypeNameCache =  "iPad Air 2"}
        else if platform == "iPad5,3" {deviceTypeNameCache =  "iPad Air 2"}
        else if platform == "iPad5,2" {deviceTypeNameCache =  "iPad Mini 4"}
        else if platform == "iPad5,1" {deviceTypeNameCache =  "iPad Mini 4"}
        else if platform == "iPad4,9" {deviceTypeNameCache =  "iPad Mini 3"}
        else if platform == "iPad4,8" {deviceTypeNameCache =  "iPad Mini 3"}
        else if platform == "iPad4,7" {deviceTypeNameCache =  "iPad Mini 3"}
        else if platform == "iPad4,6" {deviceTypeNameCache =  "iPad Mini 2"}
        else if platform == "iPad4,5" {deviceTypeNameCache =  "iPad Mini 2"}
        else if platform == "iPad4,4" {deviceTypeNameCache =  "iPad Mini 2"}
        else if platform == "iPad4,3" {deviceTypeNameCache =  "iPad Air"}
        else if platform == "iPad4,2" {deviceTypeNameCache =  "iPad Air"}
        else if platform == "iPad4,1" {deviceTypeNameCache =  "iPad Air"}
        else if platform == "iPad3,6" {deviceTypeNameCache =  "iPad 4"}
        else if platform == "iPad3,5" {deviceTypeNameCache =  "iPad 4"}
        else if platform == "iPad3,4" {deviceTypeNameCache =  "iPad 4"}
        else if platform == "iPad3,3" {deviceTypeNameCache =  "iPad 3"}
        else if platform == "iPad3,2" {deviceTypeNameCache =  "iPad 3"}
        else if platform == "iPad3,1" {deviceTypeNameCache =  "iPad 3"}
        else if platform == "iPad2,7" {deviceTypeNameCache =  "iPad Mini 1"}
        else if platform == "iPad2,6" {deviceTypeNameCache =  "iPad Mini 1"}
        else if platform == "iPad2,5" {deviceTypeNameCache =  "iPad Mini 1"}
        else if platform == "iPad2,4" {deviceTypeNameCache =  "iPad 2"}
        else if platform == "iPad2,3" {deviceTypeNameCache =  "iPad 2"}
        else if platform == "iPad2,2" {deviceTypeNameCache =  "iPad 2"}
        else if platform == "iPad2,1" {deviceTypeNameCache =  "iPad 2"}
        else if platform == "iPad1,1" {deviceTypeNameCache =  "iPad 1"}
        //simulator
        else if platform == "i386" {deviceTypeNameCache =  "iPhone Simulator"}
        else if platform == "x86_64" {deviceTypeNameCache =  "iPhone Simulator"}
        // 未知設備，可能是新出的机型，这里没有及时更新
        else {
            deviceTypeNameCache = platform
        }
        
        return deviceTypeNameCache
    }
    
    /// 系统版本
    public static func systemOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 磁盘总空间 (以byte为单位)
    public static func totalDiskSpaceInBytes() -> Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
              let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /// 磁盘剩余空间 (以byte为单位)
    public static func freeDiskSpaceInBytes() -> Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
               let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    
    /// 磁盘已用空间 (以byte为单位)
    public static func usedDiskSpaceInBytes() -> Int64 {
        return totalDiskSpaceInBytes() - freeDiskSpaceInBytes()
    }
    
    /// cpu使用率
    public static func cpuUsage() -> Double {
        var totalUsageOfCPU: Double = 0.0
        var threadsList: thread_act_array_t?
        var threadsCount = mach_msg_type_number_t(0)
        let threadsResult = withUnsafeMutablePointer(to: &threadsList) {
            return $0.withMemoryRebound(to: thread_act_array_t?.self, capacity: 1) {
                task_threads(mach_task_self_, $0, &threadsCount)
            }
        }
        
        if threadsResult == KERN_SUCCESS, let threadsList = threadsList {
            for index in 0..<threadsCount {
                var threadInfo = thread_basic_info()
                var threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
                let infoResult = withUnsafeMutablePointer(to: &threadInfo) {
                    $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                        thread_info(threadsList[Int(index)], thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
                    }
                }
                
                guard infoResult == KERN_SUCCESS else {
                    break
                }
                
                let threadBasicInfo = threadInfo as thread_basic_info
                if threadBasicInfo.flags & TH_FLAGS_IDLE == 0 {
                    totalUsageOfCPU = (totalUsageOfCPU + (Double(threadBasicInfo.cpu_usage) / Double(TH_USAGE_SCALE) * 100.0))
                }
            }
        }
        
        vm_deallocate(mach_task_self_, vm_address_t(UInt(bitPattern: threadsList)), vm_size_t(Int(threadsCount) * MemoryLayout<thread_t>.stride))
        return totalUsageOfCPU
    }
    
    /// 内存
    ///
    /// - Returns: appUsed 自己app用量 allUsed为所有合计用量  total 总共用量
    public static func memoryUsage() -> (appUsed: UInt64, allUsed: UInt64, total: UInt64) {
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        
        var appUsed: UInt64 = 0
        var totalUsed: UInt64 = 0
        if result == KERN_SUCCESS {
            // 获取自身app占用内存量
            appUsed = UInt64(taskInfo.phys_footprint)
        }
        
        // 获取所有已用内存量
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        let capacity = MemoryLayout.size(ofValue: vmStat)
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: MemoryLayout.size(ofValue: capacity) / MemoryLayout<Int32>.stride)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            totalUsed = (UInt64)((vm_size_t)(vmStat.active_count + vmStat.inactive_count + vmStat.wire_count) * pagesize)
        }
        else {
            //log("Failed to get Virtual memory inforor")
        }
        
        let total = ProcessInfo.processInfo.physicalMemory
        return (appUsed, totalUsed, total)
    }
    
}
