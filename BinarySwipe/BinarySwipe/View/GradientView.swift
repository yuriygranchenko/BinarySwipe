//
//  GradientView.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    convenience init(startColor: UIColor, endColor: UIColor? = nil, contentMode: UIViewContentMode = .Bottom) {
        self.init(frame: CGRect.zero)
        self.contentMode = contentMode
        self.startColor = startColor
        self.endColor = endColor
        updateColors()
        updateContentMode()
    }
    
    @IBInspectable var startColor: UIColor? {
        didSet { updateColors() }
    }
    
    @IBInspectable var endColor: UIColor? {
        didSet { updateColors() }
    }
    
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet { updateLocations() }
    }
    
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet { updateLocations() }
    }
    
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        awake()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        awake()
    }
    
    private func awake() {
        updateColors()
        updateLocations()
        let layer = self.layer as! CAGradientLayer
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func updateColors() {
        guard let startColor = startColor else { return }
        let layer = self.layer as! CAGradientLayer
        layer.colors = [startColor.CGColor, (endColor ?? startColor.colorWithAlphaComponent(0)).CGColor]
    }
    
    private func updateLocations() {
        let layer = self.layer as! CAGradientLayer
        layer.locations = [startLocation, endLocation]
    }
    
    private func updateContentMode() {
        let layer = self.layer as! CAGradientLayer
        switch contentMode {
        case .Top:
            layer.startPoint = CGPoint(x: 0.5, y: 0);
            layer.endPoint = CGPoint(x: 0.5, y: 1);
        case .Left:
            layer.startPoint = CGPoint(x: 0, y: 0.5);
            layer.endPoint = CGPoint(x: 1, y: 0.5);
        case .Right:
            layer.startPoint = CGPoint(x: 1, y: 0.5);
            layer.endPoint = CGPoint(x: 0, y: 0.5);
        default:
            layer.startPoint = CGPoint(x: 0.5, y: 1);
            layer.endPoint = CGPoint(x: 0.5, y: 0);
        }
    }
    
    override var contentMode: UIViewContentMode {
        didSet {
            updateContentMode()
        }
    }
}

