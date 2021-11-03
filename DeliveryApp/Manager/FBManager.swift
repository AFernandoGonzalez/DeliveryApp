//
//  FBManager.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import Foundation
import SwiftyJSON
import FBSDKLoginKit


class FBManager {
    
    static let shared = LoginManager()
    
    public class func getFBUserData(compleationHandler: @escaping () -> Void) {
        if (AccessToken.current != nil ) {
            GraphRequest(graphPath: "me", parameters: ["fields" : "name, email, picture.type(normal)"]).start { (connection, result, error) in
                //check if theres any errors
                if (error == nil) {
                    let json = JSON(result!)
                    print(json)
                    
                    //User data info
                    User.currenUser.setInfo(json: json)
                    //
                    compleationHandler()
                }
            }
        }
    }
    
    
}
