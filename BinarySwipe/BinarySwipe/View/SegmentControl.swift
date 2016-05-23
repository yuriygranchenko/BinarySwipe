//
//  SegmentControl.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SegmentedControlDelegate {
    optional func segmentedControl(control: SegmentedControl, didSelectSegment segment: Int)
    optional func segmentedControl(control: SegmentedControl, shouldSelectSegment segment: Int) -> Bool
}

final class SegmentedControl: UIControl {
    
    private lazy var controls: [UIControl] = self.subviews.reduce([UIControl](), combine: {
        if let control = $1 as? UIControl {
            return $0 + [control]
        } else {
            return $0
        }
    })
    
    override func awakeFromNib() {
        super.awakeFromNib()
        controls.all({ $0.addTarget(self, action: #selector(self.selectSegmentTap(_:)), forControlEvents: .TouchUpInside) })
    }
    
    var selectedSegment: Int {
        get { return controls.indexOf({ $0.selected }) ?? NSNotFound }
        set { setSelectedControl(controlForSegment(newValue)) }
    }
    
    @IBOutlet weak var delegate: SegmentedControlDelegate?
    
    func deselect() {
        selectedSegment = NSNotFound
    }
    
    func selectSegmentTap(sender: UIControl) {
        if let index = controls.indexOf(sender) where !sender.selected {
            
            guard (delegate?.segmentedControl?(self, shouldSelectSegment:index) ?? true) else { return }
            
            setSelectedControl(sender)
            delegate?.segmentedControl?(self, didSelectSegment:index)
            sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    private func setSelectedControl(control: UIControl?) {
        controls.all({ $0.selected = $0 == control })
    }
    
    func controlForSegment(segment: Int) -> UIControl? {
        return controls[safe: segment]
    }
}

