//
//  AZLNetworkUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2023/4/27.
//

import Foundation
import CoreTelephony
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork

/// 网络相关的工具类
public struct AZLNetworkUtil {
    private init() {}
    
    /// 网络类型
    public enum NetworkType {
        case wifi
        case cellular
        
        func ifaName() -> String {
            switch self {
            case .wifi:
                return "en0"
            case .cellular:
                return "pdp_ip0"
            }
        }
    }
    
    /// wifi是否开启
    public static func isWifiOn() -> Bool {
        return self.ipAddressWithType(.wifi) != nil
    }
    
    /// 蜂窝网络是否开启
    public static func isCellularOn() -> Bool {
        return self.ipAddressWithType(.cellular) != nil
    }
    
    /// 获取对应类型的ip地址
    public static func ipAddressWithType(_ type: NetworkType) -> String? {
        return self.ipAddressWithIfaName(type.ifaName())
    }
    
    /// 获取对应类型的ip地址
    /// 如果没有找到，会返回空
    public static func ipAddressWithIfaName(_ targetName: String) -> String? {
        
        var ipAddress: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let flags = Int32(ptr!.pointee.ifa_flags)
                //var addr = ptr!.pointee.ifa_addr.pointee
                
                if let ifaName = String(validatingUTF8: ptr!.pointee.ifa_name), ifaName == targetName {
                    var addr = ptr!.pointee.ifa_addr.pointee
                    
                    if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                        if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            if getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                                if let address = String(validatingUTF8: hostname) {
                                    ipAddress = address
                                    break
                                }
                            }
                        }
                    }
                }
                
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return ipAddress
    }
    
    //获取 WiFi 信息
    public static func getWifiInfo() -> (ssid: String, mac: String)? {
      if let cfas: NSArray = CNCopySupportedInterfaces() {
        for cfa in cfas {
          if let dict = CFBridgingRetain(
            CNCopyCurrentNetworkInfo(cfa as! CFString)
            ) {
            if let ssid = dict["SSID"] as? String,
              let bssid = dict["BSSID"] as? String {
              return (ssid, bssid)
            }
          }
        }
      }
      return nil
    }
    
    /// 获取网络类型
    public static func getNetworkType() -> String {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = __uint8_t(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { address in
                SCNetworkReachabilityCreateWithAddress(nil, address)
            }
        }
        guard let defaultRouteReachability = defaultRouteReachability else {
            return "notReachable"
        }
        var flags = SCNetworkReachabilityFlags()
        let didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        
        guard didRetrieveFlags == true,
              (flags.contains(.reachable) && !flags.contains(.connectionRequired)) == true
        else {
            return "notReachable"
        }
        if flags.contains(.connectionRequired) {
            return "notReachable"
        } else if flags.contains(.isWWAN) {
            return self.cellularType()
        } else {
            return "WiFi"
        }
    }
        
    /// 获取蜂窝数据类型
    public static func cellularType() -> String {
        
        let info = CTTelephonyNetworkInfo()
        var status: String
        
        if #available(iOS 12.0, *) {
            guard let dict = info.serviceCurrentRadioAccessTechnology,
                  let firstKey = dict.keys.first,
                  let statusTemp = dict[firstKey] else {
                return "notReachable"
            }
            status = statusTemp
        } else {
            guard let statusTemp = info.currentRadioAccessTechnology else {
                return "notReachable"
            }
            status = statusTemp
        }
        
        if #available(iOS 14.1, *) {
            if status == CTRadioAccessTechnologyNR || status == CTRadioAccessTechnologyNRNSA {
                return "5G"
            }
        }
        
        switch status {
        case CTRadioAccessTechnologyGPRS,
            CTRadioAccessTechnologyEdge,
        CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyWCDMA,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
            CTRadioAccessTechnologyeHRPD,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
        CTRadioAccessTechnologyCDMAEVDORevB:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return "notReachable"
        }
    }
}
