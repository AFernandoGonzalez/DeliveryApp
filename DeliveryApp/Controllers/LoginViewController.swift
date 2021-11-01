//
//  LoginViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
    
    //
    var fbloginSuccess = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (AccessToken.current != nil && fbloginSuccess == true) {
            performSegue(withIdentifier: "CustomerView", sender: self)
        }
    }
    

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
                        self.fbloginSuccess = true
                    }
            
            })
        }
    }
    
    
    
    
    

}
