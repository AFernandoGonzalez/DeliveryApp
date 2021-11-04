//
//  Meal.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/3/21.
//

import Foundation
import SwiftyJSON

class Meal {
    var id: Int?
    var name: String?
    var short_description: String?
    var image: String?
    var price: Float?
    //other variables

    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.short_description = json["short_description"].string
        self.image = json["image"].string
        self.price = json["price"].float
        //refer other variables here
    }
}
