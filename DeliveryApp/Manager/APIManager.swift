//
//  APIManager.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/2/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class APIManager {
    static let shared = APIManager()
    
    let baseURL = NSURL(string: BASE_URL)
    
    var accessToken = ""
    var refreshToken = ""
    var expired = Date()
    
    
    //APi to login the user
    func login(userType: String, completitionHandler: @escaping (NSError?) -> Void) {
        
        let path = "api/social/convert-token/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "grant_type": "convert_token",
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "backend" : "facebook",
            "token" : AccessToken.current!.tokenString,
            "user_type" : userType,
        ]
        
        //Using alamofire for the request
        AF.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseJSON{(response) in
            switch response.result {
            case .success(let value):
                
                let jsonData = JSON(value)
                
                self.accessToken = jsonData["access_token"].string!
                self.refreshToken = jsonData["refresh_token"].string!
                self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expires_in"].int!))
                
                completitionHandler(nil)
                break
                
                
            case .failure(let error):
                completitionHandler(error as NSError)
                break
                
            }
        }
        
        
    }
    

    //Aoi to logout the user
    func logout(completionHandler: @escaping (NSError?) -> Void) {
        let path = "api/social/revoke-token/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "token" : self.accessToken,
            
        ]
        
        // Alamofire for the requests
        AF.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseJSON{(response) in
            
            switch response.result {
            case .success:
                completionHandler(nil)
                break
            
            case .failure(let error):
                completionHandler(error as NSError?)
            }
          
        
        }
        
        
        
    }

    //API to refresh token whenis expired
    func refreshTokenIfNeed(completionHandler: @escaping () -> Void) {
        let path = "api/social/refresh-token/"
        let url = baseURL?.appendingPathComponent(path)
        let params: [String: Any] = [
            "access_token": self.accessToken,
            "refresh_token": self.refreshToken,
        ]
        
        if (Date() > self.expired) {
            AF.request(url!, method: .post, parameters: params, encoding: URLEncoding() , headers: nil).responseJSON(completionHandler: {(response) in
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    self.accessToken = jsonData["access_token"].string!
                    self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expired_in"].int!))
                    completionHandler()
                    break
                    
                case .failure:
                    break
                }
            })
        }else {
            completionHandler()
        }
        
    }
    
    //API for getting restaurants list
    func getRestaurants(completionHandler: @escaping (JSON?) -> Void) {
        let path = "api/customer/restaurants/"
        let url = baseURL?.appendingPathComponent(path)
        
        refreshTokenIfNeed {
            AF.request(url!, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler:{(response) in
                switch response.result{
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                    break
                    
                case .failure:
                    completionHandler(nil)
                    break
                    
                }
            })
            
        }
    }
    
    
   //
    
}
