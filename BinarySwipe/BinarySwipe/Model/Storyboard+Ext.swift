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
    static let SignIn = StoryboardObject<SignInViewController>("signin")
    static let Login = StoryboardObject<LoginViewController>("login")
    static let CreateAccount = StoryboardObject<CreateAccountViewController>("createAccount")
}

extension UIStoryboard {
    
    @nonobjc static let main = UIStoryboard(name: "Main", bundle: nil)
    
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