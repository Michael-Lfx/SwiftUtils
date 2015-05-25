import Foundation

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
}
