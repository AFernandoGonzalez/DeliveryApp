//
//  ProfileViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileAvatarImg: UIImageView!
    @IBOutlet weak var profileuseremail: UILabel!
    @IBOutlet weak var profileusername: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileusername.text = User.currenUser.name
        profileuseremail.text = User.currenUser.email
        
        profileAvatarImg.image = try! UIImage(data: Data (contentsOf: URL(string: User.currenUser.pictureURL!)!))

        
    }
    
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "CustomerLogout" {
//
//            //
//            APIManager.shared.logout(completionHandler: { (error) in
//                if error == nil {
//                    FBManager.shared.logOut()
//                    User.currenUser.resetInfo()
//
//                    //
//                    let storybard = UIStoryboard(name: "Main", bundle: nil)
//                    let appController = storybard.instantiateViewController(withIdentifier: "MainController") as! LoginViewController
//
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window!.rootViewController = appController
//                }
//            })
//
//            return false
////            FBManager.shared.logOut()
////            User.currenUser.resetInfo()
//        }
//        return true
//    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomerLogout" {
            
            //
            APIManager.shared.logout(completionHandler: { (error) in
                if error == nil {
                    FBManager.shared.logOut()
                    User.currenUser.resetInfo()
                    
                    //
                    let storybard = UIStoryboard(name: "Main", bundle: nil)
                    let appController = storybard.instantiateViewController(withIdentifier: "MainController") as! LoginViewController
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window!.rootViewController = appController
                }
            })
//            FBManager.shared.logOut()
//            User.currenUser.resetInfo()
        }
    }

}
