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
    
    //login with facebook
    var userType: String = USER_TYPE_CUSTOMER
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if AccessToken.current != nil {
            logoutFBButton.isHidden = false
            FBManager.getFBUserData(compleationHandler: {
                self.loginFBButton.setTitle("Continue as \(User.currenUser.email!)", for: .normal)
                //self.loginFBButton.sizeToFit()
            } )
        } else {
            self.logoutFBButton.isHidden = true
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
        
        //
        APIManager.shared.logout { (error) in
            if error == nil {
                FBManager.shared.logOut()
                User.currenUser.resetInfo()
                
                self.loginFBButton.isHidden = true
                self.loginFBButton.setTitle("Login with facebook", for: .normal)
            }
        }
        
        
        
        //
        
//        FBManager.shared.logOut()
//        User.currenUser.resetInfo()
//
//        loginFBButton.isHidden = true
//        loginFBButton.setTitle("Login with facebook", for: .normal)
        
    }
    
    
    
    
    //
    

    @IBAction func facebookLoginButton(_ sender: Any) {
        if (AccessToken.current != nil) {
            //
            APIManager.shared.login(userType: userType, completitionHandler: {
                (error) in
                if error == nil {
                    self.fbloginSuccess = true
                    self.viewDidAppear(true)
                }
                
            })
            
            //
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
                            
                            //
                            //
                            APIManager.shared.login(userType: self.userType, completitionHandler: {
                                (error) in
                                if error == nil {
                                    self.fbloginSuccess = true
                                    self.viewDidAppear(true)
                                }
                                
                            })
                            
                            //
                            
                            self.fbloginSuccess = true
                            self.viewDidAppear(true)
                        })
                        
                        
                    }
            
            })
        }
    }
    
    
    
   
    
    
    
    

}
