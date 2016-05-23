//
//  LoginViewController.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet var signInButton: Button!
    
    override func viewDidLoad() {
        signInButtonConfigure()
    }
    
    private func signInButtonConfigure() {
        let title = NSMutableAttributedString(string:"Sign In".ls)
        let range = NSMakeRange(0, title.length)
        title.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range)
        title.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(15.0), range: range)
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
        signInButton.setAttributedTitle(title, forState: .Normal)
    }
}