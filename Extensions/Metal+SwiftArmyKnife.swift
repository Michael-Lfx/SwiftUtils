// 提供Metal专用工具

import UIKit

#if  METAL

import Metal
    
extension UIColor {
    
    /**
    若无法取出其中RGB分量，则返回不透明黑色MTLClearColor
    */
    var toMetalColor: MTLClearColor {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return MTLClearColor(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
    
}

#else
    
#endif

