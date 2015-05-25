// 参考 https://github.com/chaoyuan899/KCTextView
// 已简单测试

import UIKit

@IBDesignable class SAKPlaceholderTextView: UITextView {
    private struct AssociatedKeys {
        static var InitializeName = "sak_InitializeName"
    }
    
    /**
    The string that is displayed when there is no other text in the text view.
    */
    @IBInspectable var placeholder: String = "在此输入内容" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /**
    The color of the placeholder.
    */
    @IBInspectable var placeholderTextColor: UIColor! = UIColor(white: 0.702, alpha: 1)
    
    // MARK: - Accessors
    
    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func insertText(text: String) {
        super.insertText(text)
        setNeedsDisplay()
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet{
            setNeedsDisplay()
        }
    }
    
    // MARK: - NSObject
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: self)
    }
    
    // MARK: - UIView
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    override func drawRect(var rect: CGRect) {
        super.drawRect(rect)
        
        if count(text) ==  0 && placeholder != "" {
            // Inset the rect
            rect = UIEdgeInsetsInsetRect(rect, contentInset)
            // HAX: This is hacky. Not sure why 8 is the magic number
            if contentInset.left == 0.0 {
                rect.origin.x += 8.0
            }
            rect.origin.y += 8.0
            
            // Draw the text
            
            // HAX: The following lines are inspired by http://stackoverflow.com/questions/18948180/align-text-using-drawinrectwithattributes  thanks @Hejazi.
            // Make a copy of the default paragraph style
            var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            // Set line break mode
            paragraphStyle.lineBreakMode = .ByTruncatingTail
            // Set text alignment
            paragraphStyle.alignment = .Left
            let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: placeholderTextColor]
            
            placeholder.drawInRect(rect, withAttributes: attributes)
        }
    }
    
    // MARK: - Private
    private func initialize() {
        let obj = objc_getAssociatedObject(self, &AssociatedKeys.InitializeName) as? NSString
        if obj == nil {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: self)
            layer.drawsAsynchronously = true
            objc_setAssociatedObject(self, &AssociatedKeys.InitializeName, "SAKPlaceholderTextView", UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    func textChanged(notification: NSNotification) {
        setNeedsDisplay()
    }
}
