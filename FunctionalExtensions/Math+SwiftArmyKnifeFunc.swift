import Foundation

// MARK: 弧度、角度转换

/**
角度转换成弧度

:param: degrees 角度

:returns: 弧度
*/
@inline(__always) func degreesToRadians(degrees: Double) -> Double {
    return degrees * M_PI / 180.0
}

/**
弧度转换成角度

:param: radians 弧度

:returns: 角度
*/
@inline(__always) func radiansToDegrees(radians: Double) -> Double {
    return radians * 180.0 / M_PI
}
