//
//  BaseLoginViewController.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation
import UIKit

class BaseLoginViewController: BaseViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet var helperButton: Button!
    
    override func viewDidLoad() {
        signInButtonConfigure()
        configureFacebook()
    }
    
    func configureFacebook() {
        facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"];
        facebookLoginButton.delegate = self
    }
    
    private func signInButtonConfigure() {
        let title = NSMutableAttributedString(string:helperButton.titleLabel?.text ?? "")
        let range = NSMakeRange(0, title.length)
        title.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range)
        title.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(15.0), range: range)
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
        helperButton.setAttributedTitle(title, forState: .Normal)
    }
    
    //MARK: Facebook handler
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, location"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            guard error == nil else { return }
            var user = User.currentUser
            user.id = result.valueForKey("id") as? String
            user.firstName = result.valueForKey("first_name") as? String
            user.lastName = result.valueForKey("last_name") as? String
            user.email = result.valueForKey("email") as? String
            if let fb_location = result.valueForKey("location"), let location = fb_location.valueForKey("name") as? String {
                user.location = Location(location: location)
            }
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
}

class SignInViewController: BaseLoginViewController {
    
    @IBAction func helperButtonClick(sender: AnyObject) {
        navigationController?.pushViewController(Storyboard.Login.instantiate(), animated: true)
    }
}

class LoginViewController: BaseLoginViewController {
    
    @IBAction func helperButtonClick(sender: AnyObject) {
        navigationController?.pushViewController(Storyboard.CreateAccount.instantiate(), animated: true)
    }
}

class CreateAccountViewController: BaseLoginViewController {
    
    @IBAction func helperButtonClick(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}