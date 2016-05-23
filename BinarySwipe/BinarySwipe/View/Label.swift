//
//  Label.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel {
    
    convenience init(icon: String, size: CGFloat = UIFont.systemFontSize(), textColor: UIColor = UIColor.whiteColor()) {
        self.init()
        font = UIFont.binarySwipe(size)
        text = icon
        self.textColor = textColor
    }

    @IBInspectable var localize: Bool = false {
        willSet {
            if newValue {
                text = text?.ls
                layoutIfNeeded()
            }
        }
    }
}