import UIKit
import AssetsLibrary

// MARK: GCD

/// 用法：任何子线程或队列中调用 `updateViewWithClosure(tableView.reloadData())`
@inline(__always) func updateViewWithClosure(@autoclosure(escaping) closure: () -> Void) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

/// 用法：任何子线程或队列中调用 `updateViewWithClosure({ tableView.reloadData() })` 或 `updateViewWithClosure(){ tableView.reloadData() }`
@inline(__always) func updateViewWithClosure(closure: () -> Void) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

/**
异步分派闭包至优先级为DISPATCH_QUEUE_PRIORITY_DEFAULT的全局并发队列

:param: closure 耗时子任务
*/
@inline(__always) func asyncTaskWithDefaultPriorityGlobalQueue(@autoclosure(escaping) closure: () -> Void) {
    asyncTaskWithGlobalQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, withClosure: closure)
}

@inline(__always) func asyncTaskWithDefaultPriorityGlobalQueue(closure: () -> Void) {
    asyncTaskWithGlobalQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, withClosure: closure)
}

/**
异步分派闭包至对应优先级的全局并发队列

:param: queueIdentifier 全局并发队列标识
:param: closure 耗时子任务
*/
@inline(__always) func asyncTaskWithGlobalQueue(queueIdentifier: Int, @autoclosure(escaping) withClosure closure: () -> Void) {
    asyncTaskWithQueue(dispatch_get_global_queue(queueIdentifier, 0), withClosure: closure)
}

@inline(__always) func asyncTaskWithGlobalQueue(queueIdentifier: Int, withClosure closure: () -> Void) {
    asyncTaskWithQueue(dispatch_get_global_queue(queueIdentifier, 0), withClosure: closure)
}

/**
异步分派闭包至对应的队列

:param: queue 队列
:param: closure 耗时子任务
*/
@inline(__always) func asyncTaskWithQueue(queue: dispatch_queue_t, @autoclosure(escaping) withClosure closure: () -> Void) {
    dispatch_async(queue, closure)
}

@inline(__always) func asyncTaskWithQueue(queue: dispatch_queue_t, withClosure closure: () -> Void) {
    dispatch_async(queue, closure)
}

/**
异步分派闭包至对应优先级的全局并发队列

:param: identifier 全局并发队列标识
:param: closure 耗时子任务
*/
func concurrentBackgroundTaskWithClosure(calculateClosure: () -> Void, updateViewWithClosure updateViewClosure: () -> Void) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        () -> Void in
        calculateClosure()
        updateViewWithClosure(updateViewClosure)
    }
}

// MARK: - UIKit

extension UIColor {
    /**
    从16进制RGB值生成对应的UIColor对象
    
    :param: rgb 16进制RGB值，如0xFFEEDD
    
    :returns: UIColor!
    */
    class func colorWithHexRGB(rgb: Int) -> UIColor {
        return colorWithHexAlphaRGB(rgb, alpha: 1.0)
    }
    
    /**
    从16进制AlphaRGB值生成对应的UIColor对象
    
    :param: rgb 16进制RGB值，如0xFFEEDD
    :param: alpha 透明通道值，范围[0, 1]
    
    :returns: UIColor!
    */
    class func colorWithHexAlphaRGB(rgb: Int, alpha: CGFloat) -> UIColor {
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func colorWithRGB(#red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return colorWithAlphaRGB(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func colorWithAlphaRGB(#red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    class var UILabeldefaultTextColor: UIColor! {
        let label = UILabel()
        return label.textColor
    }
    
    // MARK: 常用颜色
    
    class var lightOrange: UIColor {
        return UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)
    }
    
    class var medOrange: UIColor {
        return UIColor(red: 0.973, green: 0.338, blue: 0.173, alpha: 1)
    }
    
    class var darkOrange: UIColor {
        return UIColor(red: 0.7, green: 0.2, blue: 0.1, alpha: 1)
    }
    
}

// MARK: HSV - 六角锥体模型（Hexcone Model）

struct HSV: Equatable, Printable {
    
    var hue: Int
    var saturation: Int
    var value: Int
    
    static var HSVZero: HSV {
        let zero = HSV(hue: 0, saturation: 0, value: 0)
        return zero
    }
    
    static func hsvFromString(hsvString: String) -> HSV {
        let components = hsvString.componentsSeparatedByString(", ")
        if components.count != 3 {
            return HSVZero
        }
        return HSV(hue: components[0].toInt()!, saturation: components[1].toInt()!, value: components[2].toInt()!)
    }
    
    var description: String {
        return "\(hue), \(saturation), \(value)"
    }
}

func ==(lhs: HSV, rhs: HSV) -> Bool {
    return (lhs.hue == rhs.hue) && (lhs.saturation == rhs.saturation) && (lhs.value == rhs.value)
}

extension UIView {
    
    /**
    设置视图宽度
    
    :param: width 宽度值.
    
    */
    var frameWidth: CGFloat {
        get {
            return frame.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /**
    设置视图高度
    
    :param: height 高度值.
    
    */
    var frameHeight: CGFloat {
        get {
            return frame.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /**
    设置视图相对父视图的x坐标
    
    :param: originX x坐标值.
    
    */
    var frameOriginX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return frame.originX
        }
    }
    
    /**
    设置视图相对父视图的y坐标
    
    :param: originY y坐标值.
    
    */
    var frameOriginY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return frame.originY
        }
    }
    
    // MARK: 动画
    
    func defaultShakeAnimation() {
        shakeAnimation(margin: 15, duration: 0.2, repeatCount: 2)
    }
    
    func shakeAnimation(#margin: CGFloat, duration: CFTimeInterval, repeatCount: Float) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.values = [0, -margin, margin, 0]
        shakeAnimation.duration = duration
        shakeAnimation.repeatCount = repeatCount
        layer.addAnimation(shakeAnimation, forKey: "shakeAnimation")
    }
    
}

extension UIScreen {
    /**
    返回主屏幕宽度
    
    :returns: CGFloat
    */
    class var mainScreenWidth: CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    /**
    返回主屏幕度度
    
    :returns: CGFloat
    */
    class var mainScreenHeight: CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
    
    class var mainScreenBounds: CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    class var mainScreenScale: CGFloat {
        return UIScreen.mainScreen().scale
    }
}

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage! {
        return UIImage.imageWithColor(color, withFrame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    class func imageWithColor(color: UIColor, withFrame frame: CGRect) -> UIImage! {
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func compressJPGImageToQuality(image: UIImage, quality: CGFloat) -> UIImage? {
        let rawData = UIImageJPEGRepresentation(image, quality)
        return UIImage(data: rawData, scale: UIScreen.mainScreenScale)
    }
    
    func scaleCompress(image: UIImage!, scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale,image.size.height * scale));
        image.drawInRect(CGRectMake(0, 0, image.size.width * scale, image.size.height * scale))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage
    }
}

extension UILabel {
    
    var textHeight: CGFloat {
        let attributes = [NSFontAttributeName: font]
        var rect: CGRect? = nil
        if let textValue = text {
            rect = textValue.boundingRectWithSize(
                CGSize(width: frameWidth, height: CGFloat(MAXFLOAT)),
                options: .UsesLineFragmentOrigin,
                attributes: attributes,
                context: nil)
        }
        return rect == nil ? 0 : rect!.size.height
    }
    
}

extension CATransaction {
    
    @inline(__always) static func enableActionsWithClosure(closure: () -> Void) {
        setActions(true, withClosure: closure)
    }
    
    @inline(__always) static func disableActionsWithClosure(closure: () -> Void) {
        setActions(false, withClosure: closure)
    }
    
    static func setActions(enable: Bool, withClosure closure: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(enable)
        closure()
        CATransaction.commit()
    }
    
}
