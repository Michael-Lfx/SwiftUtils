import Foundation

// MARK: NSUserDefaults

public typealias UserDefaults = NSUserDefaults -> NSUserDefaults

public func standardUserDefaultsSetValue<T: AnyObject>(value: T?, forKey defaultName: String) -> UserDefaults {
    return { ud in
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
        
        return ud
    }
}

