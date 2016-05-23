//
//  Constants.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let pixelSize: CGFloat = 1.0
    static let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    static let isPhone: Bool = UI_USER_INTERFACE_IDIOM() == .Phone
    static let groupIdentifier = "group.com.EP.BinarySwipe"
}

typealias Block = Void -> Void
typealias ObjectBlock = AnyObject? -> Void
typealias FailureBlock = NSError? -> Void
typealias BooleanBlock = Bool -> Void

extension NSURL {
    
    class func groupContainer() -> NSURL {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(Constants.groupIdentifier) ?? documents()
    }
    
    class func documents() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last ?? NSURL(fileURLWithPath: "")
    }
}