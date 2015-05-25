// 改写自 https://github.com/hoteltonight/HTCopyableLabel
// 已简单测试

import UIKit

@IBDesignable public class SAKCopyableLabel: UILabel {
    
    // MARK: - 属性
    
    @IBInspectable var copyingEnabled: Bool = true {
        didSet {
            userInteractionEnabled = copyingEnabled
            longPressGestureRecognizer.enabled = copyingEnabled
        }
    }
    
    var copyMenuArrowDirection = UIMenuControllerArrowDirection.Default
    
    private(set) lazy var longPressGestureRecognizer: UILongPressGestureRecognizer! = {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        self.addGestureRecognizer(longPressGestureRecognizer)
        return longPressGestureRecognizer
        }()
    
    var stringToCopyForCopyableLabel: ((SAKCopyableLabel) -> String)?
    
    var copyMenuTargetRectInCopyableLabelCoordinates: ((SAKCopyableLabel) -> CGRect)?
    
    var copyPressed: ((SAKCopyableLabel) -> Void)?
    
    // MARK: - 覆盖方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userInteractionEnabled = true
    }
    
    // MARK: - 回调
    
    func longPressGestureRecognized(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer != self.longPressGestureRecognizer {
            return
        }
        if gestureRecognizer.state != .Began {
            return
        }
        becomeFirstResponder()
        let copyMenu = UIMenuController.sharedMenuController()
        if copyMenuTargetRectInCopyableLabelCoordinates != nil {
            let rect = copyMenuTargetRectInCopyableLabelCoordinates!(self)
            copyMenu.setTargetRect(rect, inView: self)
        } else {
            copyMenu.setTargetRect(bounds, inView: self)
        }
        copyMenu.arrowDirection = copyMenuArrowDirection
        copyMenu.setMenuVisible(true, animated: true)
    }
    
    // MARK: - UIResponder
    
    public override func canBecomeFirstResponder() -> Bool {
        return copyingEnabled
    }
    
    public override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        var retValue = false
        if action == "copy:" && copyingEnabled {
            retValue = true
        } else {
            // Pass the canPerformAction:withSender: message to the superclass
            // and possibly up the responder chain.
            retValue = super.canPerformAction(action, withSender: sender)
        }
        return retValue
    }
    
    public override func copy(sender: AnyObject?) {
        if !copyingEnabled {
            return
        }
        var pasteboard = UIPasteboard.generalPasteboard()
        var stringToCopy: String?
        if stringToCopyForCopyableLabel != nil {
            stringToCopy = stringToCopyForCopyableLabel!(self)
        } else {
            stringToCopy = text
        }
        pasteboard.string = stringToCopy
        if stringToCopyForCopyableLabel != nil {
            copyPressed!(self)
        }
    }

}
