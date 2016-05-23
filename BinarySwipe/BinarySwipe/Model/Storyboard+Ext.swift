//
//  Storyboard+Ext.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

func specify<T>(object: T, @noescape _ specify: T -> Void) -> T {
    specify(object)
    return object
}

struct StoryboardObject<T: UIViewController> {
    let identifier: String
    var storyboard: UIStoryboard
    init(_ identifier: String, _ storyboard: UIStoryboard = UIStoryboard.main) {
        self.identifier = identifier
        self.storyboard = storyboard
    }
    func instantiate() -> T {
        return storyboard.instantiateViewControllerWithIdentifier(identifier) as! T
    }
    func instantiate(@noescape block: T -> Void) -> T {
        let controller = instantiate()
        block(controller)
        return controller
    }
}

struct Storyboard {
//    static let Login = StoryboardObject<LoginViewController>("login")
}

extension UIStoryboard {
    
    @nonobjc static let main = UIStoryboard(name: "Main", bundle: nil)
    @nonobjc static let signUp = UIStoryboard(name: "SignUp", bundle: nil)
    @nonobjc static let camera = UIStoryboard(name: "Camera", bundle: nil)
    @nonobjc static let introduction = UIStoryboard(name: "Introduction", bundle: nil)
    
    func present(animated: Bool) {
        UINavigationController.main.viewControllers = [instantiateInitialViewController()!]
    }
    
    subscript(key: String) -> UIViewController? {
        return instantiateViewControllerWithIdentifier(key)
    }
}

extension UIWindow {
    @nonobjc static let mainWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
}

extension UINavigationController {
    
    @nonobjc static let main = specify(UINavigationController()) {
        UIWindow.mainWindow.rootViewController = $0
        $0.navigationBarHidden = true
    }
    
    public override func shouldAutorotate() -> Bool {
        return topViewController?.shouldAutorotate() ?? super.shouldAutorotate()
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations() ?? super.supportedInterfaceOrientations()
    }
}