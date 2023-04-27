//
//  AZLSystemLanguageUtil.swift
//  AZLUtil
//
//  Created by lizihong on 2023/4/11.
//

import Foundation

/*
用于获取系统语言的工具类
 */
public class AZLLanguageUtil {
    
    /**
     用于获取支持语言的 Bundle
     */
    static var bundle: Bundle = Bundle.main
    
    /**
     用于获取系统App设置语言 的UserDefaults
     */
    static var userDefault: UserDefaults = UserDefaults.standard
    
    /**
     获取App支持的语言code
     @return [String] 语言code数组
     */
    public static func getAppSupportLanguageCodes() -> [String] {
        // app支持的语言
        let langs = self.bundle.localizations
        return langs
    }
    
    /**
     获取系统设置给 App 的语言
     App 使用系统不一样的语言。iOS 13后支持，在系统设置中App的设置
     @return String 系统给app设置的语言，如果没有设置会返回空
     */
//    static func getSystemAppLanguageCode() -> String? {
//
//        let userDefault = self.userDefault
//        // AppleLocale为系统语言
//        let localeLang: String? = userDefault.value(forKey: "AppleLocale") as? String
//        let localeArray = localeLang?.split(separator: "_")
//
//        // 判断预设语言与系统语言不一致，认为是用户自己选择的(这个判断实际不太准确)
//        if let appLanguage = self.getFirstSystemLanguageCode(),
//           let firstLocal = localeArray?.first,
//           appLanguage.hasPrefix(firstLocal) == false {
//            return appLanguage
//        }
//        return nil
//    }
    
    /// 获取系统第一个语言
    public static func getFirstSystemLanguageCode() -> String? {
        // AppleLanguages为系统给app设置的语言
        let appleLanguages: [String]? = userDefault.value(forKey: "AppleLanguages") as? [String]
        if let appLanguage = appleLanguages?.first {
            return appLanguage
        }
        return nil
    }
    
    /// 获取app的语言，如 zh-Hans
    public static func getAppLanguageCode() -> String? {
        if let languageCode = Locale.current.languageCode {
            if let scriptCode = Locale.current.scriptCode {
                return languageCode+"-"+scriptCode
            }
            return languageCode
        }
        
        return nil
    }
}
