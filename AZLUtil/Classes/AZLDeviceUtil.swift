//
//  AZLDeviceUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2021/9/6.
//

import UIKit

public enum AZLInfoPlistKeyName: String {
    /// bundle id
    case bundleID = "CFBundleIdentifier"
    /// 名字
    case displayName = "CFBundleDisplayName"
    /// 发布版本
    case version = "CFBundleShortVersionString"
    /// build号
    case buildNum = "CFBundleVersion"
}

public class AZLDeviceUtil: NSObject {
    /// 设备类型缓存值
    static var deviceTypeNameCache = ""
    
    /// 获取设备类型
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
        if platform == "iPhone13,1" { 
            deviceTypeNameCache = "iPhone 12 mini"
        } else if platform == "iPhone13,2" {
            deviceTypeNameCache = "iPhone 12"
        } else if platform == "iPhone13,3" {
            deviceTypeNameCache = "iPhone 12 Pro"
        } else if platform == "iPhone13,4" {
            deviceTypeNameCache = "iPhone 12 Pro Max"
        } else if platform == "iPhone12,1" {
            deviceTypeNameCache = "iPhone 11"
        } else if platform == "iPhone12,3" {
            deviceTypeNameCache = "iPhone 11 Pro"
        } else if platform == "iPhone12,5" {
            deviceTypeNameCache = "iPhone 11 Pro Max"
        } else if platform == "iPhone12,8" {
            deviceTypeNameCache = "iPhone SE (2nd generation)"
        } else if platform == "iPhone11,8" {
            deviceTypeNameCache = "iPhone XR"
        } else if platform == "iPhone11,6" {
            deviceTypeNameCache = "iPhone XS Max"
        } else if platform == "iPhone11,4" {
            deviceTypeNameCache = "iPhone XS Max"
        } else if platform == "iPhone11,2" {
            deviceTypeNameCache = "iPhone XS"
        } else if platform == "iPhone10,6" { 
            deviceTypeNameCache = "iPhone X"
        } else if platform == "iPhone10,5" {
            deviceTypeNameCache = "iPhone 8 Plus"
        } else if platform == "iPhone10,4" { 
            deviceTypeNameCache = "iPhone 8"
        } else if platform == "iPhone10,3" {
            deviceTypeNameCache = "iPhone X"
        } else if platform == "iPhone10,2" {
            deviceTypeNameCache = "iPhone 8 Plus"
        } else if platform == "iPhone10,1" {
            deviceTypeNameCache = "iPhone 8"
        } else if platform == "iPhone9,4" { 
            deviceTypeNameCache = "iPhone 7 Plus"
        } else if platform == "iPhone9,3" { 
            deviceTypeNameCache =  "iPhone 7"
        } else if platform == "iPhone9,2" {
            deviceTypeNameCache =  "iPhone 7 Plus"
        } else if platform == "iPhone9,1" {
            deviceTypeNameCache =  "iPhone 7"
        } else if platform == "iPhone8,4" { 
            deviceTypeNameCache =  "iPhone SE"
        } else if platform == "iPhone8,2" { 
            deviceTypeNameCache =  "iPhone 6S Plus"
        } else if platform == "iPhone8,1" { 
            deviceTypeNameCache =  "iPhone 6S"
        } else if platform == "iPhone7,2" {
            deviceTypeNameCache =  "iPhone 6"
        } else if platform == "iPhone7,1" { 
            deviceTypeNameCache =  "iPhone 6 Plus"
        } else if platform == "iPhone6,2" {
            deviceTypeNameCache =  "iPhone 5S"
        } else if platform == "iPhone6,1" {
            deviceTypeNameCache =  "iPhone 5S"
        } else if platform == "iPhone5,4" { 
            deviceTypeNameCache =  "iPhone 5C"
        } else if platform == "iPhone5,3" { 
            deviceTypeNameCache =  "iPhone 5C"
        } else if platform == "iPhone5,2" { 
            deviceTypeNameCache =  "iPhone 5"
        } else if platform == "iPhone5,1" { 
            deviceTypeNameCache =  "iPhone 5"
        } else if platform == "iPhone4,1" { 
            deviceTypeNameCache =  "iPhone 4S"
        } else if platform == "iPhone3,3" { 
            deviceTypeNameCache =  "iPhone 4"
        } else if platform == "iPhone3,2" { 
            deviceTypeNameCache =  "iPhone 4"
        } else if platform == "iPhone3,1" { 
            deviceTypeNameCache =  "iPhone 4"
        } else if platform == "iPhone2,1" { 
            deviceTypeNameCache =  "iPhone 3GS"
        } else if platform == "iPhone1,2" { 
            deviceTypeNameCache =  "iPhone 3G"
        } else if platform == "iPhone1,1" { 
            deviceTypeNameCache =  "iPhone 2G"
        } else if platform == "iPod7,1" {
            // iPod 
            deviceTypeNameCache =  "iPod Touch 6G"
        } else if platform == "iPod5,1" { 
            deviceTypeNameCache =  "iPod Touch 5G"
        } else if platform == "iPod4,1" { 
            deviceTypeNameCache =  "iPod Touch 4G"
        } else if platform == "iPod3,1" { 
            deviceTypeNameCache =  "iPod Touch 3G"
        } else if platform == "iPod2,1" { 
            deviceTypeNameCache =  "iPod Touch 2G"
        } else if platform == "iPod1,1" { 
            deviceTypeNameCache =  "iPod Touch 1G"
        } else if platform == "iPad7,6" {
            //iPad 
            deviceTypeNameCache =  "iPad 6 (Cellular)"
        } else if platform == "iPad7,5" { 
            deviceTypeNameCache =  "iPad 6 (WiFi)"
        } else if platform == "iPad7,4" { 
            deviceTypeNameCache =  "iPad Pro 10.5-inch (Cellular)"
        } else if platform == "iPad7,3" { 
            deviceTypeNameCache =  "iPad Pro 10.5-inch (WiFi)"
        } else if platform == "iPad7,2" {
            deviceTypeNameCache =  "iPad Pro 12.9-inch 2nd-gen (Cellular)"
        } else if platform == "iPad7,1" { 
            deviceTypeNameCache =  "iPad Pro 12.9-inch 2nd-gen (WiFi)"
        } else if platform == "iPad6,8" { 
            deviceTypeNameCache =  "iPad Pro 12.9"
        } else if platform == "iPad6,7" { 
            deviceTypeNameCache =  "iPad Pro 12.9"
        } else if platform == "iPad6,4" { 
            deviceTypeNameCache =  "iPad Pro 9.7"
        } else if platform == "iPad6,3" { 
            deviceTypeNameCache =  "iPad Pro 9.7"
        } else if platform == "iPad5,4" { 
            deviceTypeNameCache =  "iPad Air 2"
        } else if platform == "iPad5,3" { 
            deviceTypeNameCache =  "iPad Air 2"
        } else if platform == "iPad5,2" {
            deviceTypeNameCache =  "iPad Mini 4"
        } else if platform == "iPad5,1" { 
            deviceTypeNameCache =  "iPad Mini 4"
        } else if platform == "iPad4,9" { 
            deviceTypeNameCache =  "iPad Mini 3"
        } else if platform == "iPad4,8" { 
            deviceTypeNameCache =  "iPad Mini 3"
        } else if platform == "iPad4,7" { 
            deviceTypeNameCache =  "iPad Mini 3"
        } else if platform == "iPad4,6" { 
            deviceTypeNameCache =  "iPad Mini 2"
        } else if platform == "iPad4,5" { 
            deviceTypeNameCache =  "iPad Mini 2"
        } else if platform == "iPad4,4" { 
            deviceTypeNameCache =  "iPad Mini 2"
        } else if platform == "iPad4,3" {
            deviceTypeNameCache =  "iPad Air"
        } else if platform == "iPad4,2" {
            deviceTypeNameCache =  "iPad Air"
        } else if platform == "iPad4,1" {
            deviceTypeNameCache =  "iPad Air"
        } else if platform == "iPad3,6" {
            deviceTypeNameCache =  "iPad 4"
        } else if platform == "iPad3,5" { 
            deviceTypeNameCache =  "iPad 4"
        } else if platform == "iPad3,4" {
            deviceTypeNameCache =  "iPad 4"
        } else if platform == "iPad3,3" {
            deviceTypeNameCache =  "iPad 3"
        } else if platform == "iPad3,2" { 
            deviceTypeNameCache =  "iPad 3"
        } else if platform == "iPad3,1" { 
            deviceTypeNameCache =  "iPad 3"
        } else if platform == "iPad2,7" { 
            deviceTypeNameCache =  "iPad Mini 1"
        } else if platform == "iPad2,6" { 
            deviceTypeNameCache =  "iPad Mini 1"
        } else if platform == "iPad2,5" {
            deviceTypeNameCache =  "iPad Mini 1"
        } else if platform == "iPad2,4" {
            deviceTypeNameCache =  "iPad 2"
        } else if platform == "iPad2,3" { 
            deviceTypeNameCache =  "iPad 2"
        } else if platform == "iPad2,2" {
            deviceTypeNameCache =  "iPad 2"
        } else if platform == "iPad2,1" {
            deviceTypeNameCache =  "iPad 2"
        } else if platform == "iPad1,1" { 
            deviceTypeNameCache =  "iPad 1"
        } else if platform == "i386" {
            //simulator
            deviceTypeNameCache =  "iPhone Simulator"
        } else if platform == "x86_64" {
            deviceTypeNameCache =  "iPhone Simulator"
        } else {
            //未知設備
            deviceTypeNameCache = platform
        }
        
        return deviceTypeNameCache
    }
    
    /// 系统版本
    public static func systemOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// safeArea
    public static func safeAreaInset() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if let inset = UIApplication.shared.keyWindow?.safeAreaInsets {
                return inset
            }else if let inset = UIApplication.shared.windows.first?.safeAreaInsets {
                return inset
            }
        } else {
            // Fallback on earlier versions
            
        }
        return UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    /// 默认navigationBar的高度
    public static func defaultNavBarHeight() -> CGFloat {
        return 44
    }
    
    public static func ipAddress() -> String {
        var addresses = [String]()
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first ?? "0.0.0.0"
    }
    
    /// 获取info.plist的数据
    public static func infoPlistValue(keyType:AZLInfoPlistKeyName) -> String? {
        let dict = Bundle.main.infoDictionary
        return dict?[keyType.rawValue] as? String
    }
}
