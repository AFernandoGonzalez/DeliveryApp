//
//  LoginViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginFBButton: UIButton!
    
    @IBOutlet weak var logoutFBButton: UIButton!
    
    //
    var fbloginSuccess = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if AccessToken.current != nil {
            logoutFBButton.isHidden = false
            FBManager.getFBUserData(compleationHandler: {
                self.loginFBButton.setTitle("Continue as \(User.currenUser.email!)", for: .normal)
                //self.loginFBButton.sizeToFit()
            } )
        }
        //
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (AccessToken.current != nil && fbloginSuccess == true) {
            performSegue(withIdentifier: "CustomerView", sender: self)
        }
    }
    
    
    //
    
    @IBAction func facebookLogoutButton(_ sender: Any) {
        
        FBManager.shared.logOut()
        User.currenUser.resetInfo()
        
        loginFBButton.isHidden = true
        loginFBButton.setTitle("Login with Facebook", for: .normal)
    }
    
    
    
    
    //
    

    @IBAction func facebookLoginButton(_ sender: Any) {
        if (AccessToken.current != nil) {
            fbloginSuccess = true
            self.viewDidAppear(true)
            
        }else {
            FBManager.shared.logIn(
                permissions: ["public_profile", "email"],
                from: self,
                handler:{
                    (result, error) in
                    
                    if (error == nil) {
                        
                        FBManager.getFBUserData (compleationHandler: {
                        
                            self.fbloginSuccess = true
                            self.viewDidAppear(true)
                        })
                        
                        
                    }
            
            })
        }
    }
    
    
    
   
    
    
    
    

}
