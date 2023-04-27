//
//  AZLDateUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2023/4/27.
//

import Foundation

/// 日期相关工具类
public struct AZLDateUtil {
    private init() {}
    
//    static func convertDateToNongLi2(date: Date) {
//        let calendar = Calendar.current
//        let compoment = DateComponents.init(year: 2023, month: 3, day: 23)
//        let date = calendar.date(from: compoment)!
//
//        let nongliCalendar = Calendar.init(identifier: .chinese)
//        let nongliCompo = nongliCalendar.dateComponents([.era, .year, .month, .day], from: date)
//
//        let year = nongliCompo.year
//        let month = nongliCompo.month
//        let day = nongliCompo.day
//        let era = nongliCompo.era
//
//        print("\(era) \(year) \(month) \(day)")
//    }
//
//    static func convertDateToGregorian(date: Date) {
//        let calendar = Calendar.current
//        let nongliCalendar = Calendar.init(identifier: .chinese)
//        let compoment = DateComponents.init(year: 40, month: 3, day: 13)
//        let date = nongliCalendar.date(from: compoment)!
//
//        let newCompo = calendar.dateComponents([.era, .year, .month, .day], from: date)
//
//        let year = newCompo.year
//        let month = newCompo.month
//        let day = newCompo.day
//        let era = newCompo.era
//
//        print("\(era) \(year) \(month) \(day)")
//    }
    
    /// 获取日期的农历名称（无法区分闰月）
    public static func convertDateToNongLi(date: Date) -> String {
        // MARK: - 农历格式数据
        let cDayName = [
            "初一", "初二", "初三", "初四", "初五",
            "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五",
            "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五",
            "廿六", "廿七", "廿八", "廿九", "三十"
        ]
        let cMonName = [
            "正", "二", "三", "四", "五",
            "六", "七", "八", "九", "十",
            "十一", "腊"
        ]
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)
        guard let  m = calendar?.components(.month, from: date).month else {return ""}
        guard let  d = calendar?.components(.day, from: date).day else {return ""}
        
        let mStr = cMonName[m - 1]
        let dStr = cDayName[d - 1]
        
        return "\(mStr)月\(dStr)"
    }
    
    /// 是否闰年
    public static func isLeapYear(year: Int) -> Bool {
        return year%400 == 0 || (year%4 == 0 && year%100 != 0)
    }
    
    /// 修正日，防止出现2月31日这样的问题。
    public static func fixDay(day: Int, month: Int, year: Int) -> Int {
        if month == 2 {
            if isLeapYear(year: year) {
                if day > 29 {
                    return 29
                }
            } else {
                if day > 28 {
                    return 28
                }
            }
        } else if month == 4 || month == 6 || month == 9 || month == 11 {
            if day > 30 {
                return 30
            }
        } else {
            if day > 31 {
                return 31
            }
        }
        return day
    }
    
    /// 计算某年某月有多少天
    public static func dayCount(year: Int, month: Int) -> Int {
        if month == 2 {
            if isLeapYear(year: year) {
                return 29
            } else {
                return 28
            }
        } else if month == 4 || month == 6 || month == 9 || month == 11 {
            return 30
        } else {
            return 31
        }
    }
    
}
