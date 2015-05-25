import Foundation
import AssetsLibrary

// MARK: - Foundation

extension NSDate {
    
    // MARK: Timestamp - 时间戳
    
    /// **timestamp** 时间戳字符串，纯数字组成
    class func dateFromTimestampString(timestamp: String) -> NSDate! {
        let time = timestamp.toInt()!
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time))
        return date
    }
    
    class func currentLocalTimestamp() -> String! {
        let timezone = NSTimeZone.systemTimeZone()
        return currentTimestamp(timezone: timezone)
    }
    
    class func currentGreenwichTimestamp() -> String! {
        let timezone = NSTimeZone(name: "Europe/London")!
        return currentTimestamp(timezone: timezone)
    }
    
    class func currentTimestamp(#timezone: NSTimeZone) -> String! {
        let date = NSDate()
        return timestamp(date: date, timezone: timezone)
    }
    
    class func timestamp(#date: NSDate, timezone: NSTimeZone) -> String! {
        let interval = NSTimeInterval(timezone.secondsFromGMTForDate(date))
        let localeDate = date.dateByAddingTimeInterval(interval)
        let timestamp = NSString.localizedStringWithFormat("%ld", Int64(localeDate.timeIntervalSince1970))
        return String(timestamp)
    }
    
    class var currentDateStringWithoutTimeZoneString: String {
        return dateToString(NSDate(), dateFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    static func dateToString(date: NSDate, dateFormat: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale(localeIdentifier: NSCalendarIdentifierGregorian)
        return formatter.stringFromDate(date)
    }

}

extension NSObject {
    
    /**
    在主队列上延迟指定的时间执行闭包的操作，用于更新界面
    
    :param: seconds 秒数，类型为Double
    :param: closure 闭包，将在主队列上执行
    */
    func delayWithSeconds(seconds: Double, closure: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(seconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}

extension NSUserDefaults {
    
    static func defaultsRegisterDefaults(registrationDictionary: [NSObject : AnyObject]) -> NSUserDefaults {
        NSUserDefaults.standardUserDefaults().registerDefaults(registrationDictionary)
        return NSUserDefaults.standardUserDefaults()
    }
    
    static func defaultsSetValue<T: AnyObject>(value: T?, forKey defaultName: String) -> NSUserDefaults.Type {
        let ud = NSUserDefaults.standardUserDefaults()
        
        switch value {
        case let realValue as Int:
            ud.setInteger(realValue, forKey: defaultName)
        case let realValue as Float:
            ud.setFloat(realValue, forKey: defaultName)
        case let realValue as Double:
            ud.setDouble(realValue, forKey: defaultName)
        case let realValue as Bool:
            ud.setBool(realValue, forKey: defaultName)
        case let realValue as NSURL:
            ud.setURL(realValue, forKey: defaultName)
        default:
            ud.setObject(value, forKey: defaultName)
        }
        
        return self
    }
    
    static func defaultsValueForKey<T>(name: String, inout value: T?) -> NSUserDefaults.Type {
        let ud = NSUserDefaults.standardUserDefaults()
        
        switch T.self {
        case is Int.Type:
            value = ud.integerForKey(name) as? T
        case is Float.Type:
            value = ud.floatForKey(name) as? T
        case is Double.Type:
            value = ud.doubleForKey(name) as? T
        case is Bool.Type:
            value = ud.boolForKey(name) as? T
        case is NSURL.Type:
            value = ud.URLForKey(name) as? T
        case is String.Type:
            value = ud.stringForKey(name) as? T
        case is NSData.Type:
            value = ud.dataForKey(name) as? T
        default:
            value = ud.objectForKey(name) as? T
        }
        
        return self
    }
    
    static func defaultsSynchronize() -> Bool {
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}

extension NSBundle {
    
    class func pathForResource(name: String, type: String?) -> String? {
        return NSBundle.mainBundle().pathForResource("minus", ofType: ".png")
    }
    
}
