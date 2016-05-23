//
//  Button.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

protocol Highlightable: class {
    var highlighted: Bool { get set }
}

protocol Selectable: class {
    var selected: Bool { get set }
}

extension UIControl: Highlightable, Selectable {}

extension UILabel: Highlightable, Selectable {
    var selected: Bool {
        get { return highlighted }
        set { highlighted = newValue }
    }
}

class Button : UIButton {
    
    convenience init(icon: String, size: CGFloat, textColor: UIColor = UIColor.whiteColor()) {
        self.init()
        titleLabel?.font = UIFont.binarySwipe(size)
        setTitle(icon, forState: .Normal)
        setTitleColor(textColor, forState: .Normal)
    }
    
    static let minTouchSize: CGFloat = 44.0
    
    var animated: Bool = false
    var spinner: UIActivityIndicatorView?
    
    @IBOutlet var highlightings: [UIView] = []
    @IBOutlet var selectings: [UIView] = []
    
    @IBInspectable var insets: CGSize = CGSizeZero
    @IBInspectable var spinnerColor: UIColor?
    
    @IBInspectable lazy var normalColor: UIColor = self.backgroundColor ?? UIColor.clearColor()
    @IBInspectable lazy var highlightedColor: UIColor = self.defaultHighlightedColor()
    @IBInspectable lazy var selectedColor: UIColor = self.backgroundColor ?? UIColor.clearColor()
    @IBInspectable lazy var disabledColor: UIColor = self.backgroundColor ?? UIColor.clearColor()
    
    @IBInspectable var localize: Bool = false {
        willSet {
            if newValue == true {
                setTitle(titleForState(.Normal)?.ls, forState: .Normal)
            }
        }
    }
    
    @IBInspectable var touchArea: CGSize = CGSizeMake(minTouchSize, minTouchSize)
    
    var loading: Bool = false {
        willSet {
            if loading != newValue {
                if newValue == true {
                    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .White)
                    spinner.color = spinnerColor ?? titleColorForState(.Normal)
                    var spinnerSuperView: UIView = self
                    let contentWidth = sizeThatFits(size).width
                    if (self.width - contentWidth) < spinner.width {
                        if let superView = self.superview {
                            spinnerSuperView = superView
                        }
                        spinner.center = center
                        alpha = 0
                    } else {
                        let size = bounds.size
                        spinner.center = CGPointMake(size.width - size.height/2, size.height/2)
                    }
                    spinnerSuperView.addSubview(spinner)
                    spinner.startAnimating()
                    self.spinner = spinner
                    userInteractionEnabled = false
                } else {
                    if spinner?.superview != self {
                        alpha = 1
                    }
                    spinner?.removeFromSuperview()
                    userInteractionEnabled = true
                }
            }
        }
    }
    
    override var highlighted: Bool {
        didSet {
            update()
            highlightings.all({ ($0 as? Highlightable)?.highlighted = highlighted })
        }
    }
    
    override var selected: Bool {
        didSet {
            update()
            selectings.all({ ($0 as? Selectable)?.selected = selected })
        }
    }
    
    override var enabled: Bool {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    func defaultHighlightedColor() -> UIColor {
        return self.backgroundColor ?? UIColor.clearColor()
    }
    
    func update() {
        let normalColor = self.normalColor
        let selectedColor = self.selectedColor
        let highlightedColor = self.highlightedColor
        let disabledColor = self.disabledColor
        var backgroundColor: UIColor?
        if enabled {
            if highlighted {
                backgroundColor = highlightedColor
            } else {
                backgroundColor = selected ? selectedColor : normalColor
            }
        } else {
            backgroundColor = disabledColor
        }
        if !CGColorEqualToColor(backgroundColor?.CGColor, self.backgroundColor?.CGColor) {
            setBackgroundColor(backgroundColor!, animated: animated)
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let intrinsicSize = super.intrinsicContentSize()
        return CGSizeMake(intrinsicSize.width + insets.width, intrinsicSize.height + insets.height)
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        var rect = bounds
        rect = rect.insetBy(dx: -max(0, touchArea.width - rect.width)/2, dy: -max(0, touchArea.height - rect.height)/2)
        return rect.contains(point)
    }
}

class SegmentButton: Button {
    
    override var highlighted: Bool {
        set { }
        get {
            return super.highlighted
        }
    }
}

class PressButton: Button {
    
    override func defaultHighlightedColor() -> UIColor {
        return normalColor.colorWithAlphaComponent(0.1) ?? UIColor.clearColor()
    }
}

extension UIFont {
    
    class func binarySwipe(size: CGFloat) -> UIFont! {
        return UIFont(name: "binarySwipe", size: size)
    }
}

