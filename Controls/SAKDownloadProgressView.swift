import UIKit

/// 圆圈表示下载进度
@IBDesignable class DownloadProgressView: UIView {
    
    static let startAngle = CGFloat(-M_PI_2)
    
    @IBInspectable var widthMargin: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blueColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.greenColor() {
        didSet {
            hintLabel.textColor = textColor
            hintLabel.setNeedsDisplay()
        }
    }
    @IBInspectable var lineWith: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var radius: CGFloat = 100 {
        didSet {
            properWidth(radius)
        }
    }
    
    var progress: Float = 0 {
        didSet {
            hintLabel.text = NSString(format: "%.2f%%", progress * 100) as String
            setNeedsDisplay()
        }
    }
    
    var presetWidth: CGFloat {
        return frame.size.width - 2 * widthMargin
    }
    
    lazy private var hintLabel: UILabel = {
        [unowned self] in
        let hintLabel = UILabel(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.presetWidth, height: 20)))
        hintLabel.center = self.center
        hintLabel.textAlignment = .Center
        self.addSubview(hintLabel)
        return hintLabel
        }()
    
    
    @inline(__always) func properWidth(width: CGFloat) -> CGFloat {
        return width > frame.size.width ? presetWidth : width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.drawsAsynchronously = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.drawsAsynchronously = true
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        let endAngle = CGFloat(-M_PI_2 + 2 * Double(progress) * M_PI)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: DownloadProgressView.startAngle, endAngle: endAngle, clockwise: true)
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, lineWith)
        CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor)
        CGContextStrokePath(ctx)
    }
    
}
