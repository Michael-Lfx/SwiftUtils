import Foundation

/**
计算数组所占字节大小，如果数组第一个元素为空，则认为整个数组所占内存为0
*/
@inline(__always) func sizeofArray<T>(array: [T]) -> Int {
    if let element = array.first {
        return sizeofValue(element) * count(array)
    }
    return 0
}

extension String {

    // MARK: Directory
    
    static func getDocumentDirectory() -> String! {
        return getDirectory(.DocumentDirectory)
    }
    
    static func getCacheDirectory() -> String! {
        return getDirectory(.CachesDirectory)
    }
    
    static func getDirectory(directory: NSSearchPathDirectory) -> String! {
        let directory = NSSearchPathForDirectoriesInDomains(directory, .UserDomainMask, true).first as! String
        return directory
    }
    
    func floatValue() -> Float? {
        let floatValueString = NSString(string: self)
        return floatValueString.floatValue
    }
    
    func doubleValue() -> Double? {
        let floatValueString = NSString(string: self)
        return floatValueString.doubleValue
    }
    
    var length: Int {
        return count(self)
    }
    
    // MARK: 验证
    
    var isValidEmailAddress: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluateWithObject(self)
    }

}
