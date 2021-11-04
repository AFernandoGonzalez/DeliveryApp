//
//  MealDetailsViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit
import Stripe

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealDetailName: UILabel!
    @IBOutlet weak var mealDetailDescriptionLabel: UILabel!
    @IBOutlet weak var mealDeatilPriceLabel: UILabel!
    
    
    @IBOutlet weak var lbQty: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    //it wasnt here!
    //var restaurant: [String:Any]!
    //
    var meal: [String:Any]!
    var qty = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealDetailName.text = meal["name"] as? String
        mealDetailDescriptionLabel.text = meal["short_description"] as? String
        //Displaying image
        let mealPath = meal["image"] as! String
        let mealUrl = URL(string: mealPath)
        
        mealImageView.af.setImage(withURL: mealUrl!)
    }
    

    
    
    
    //
    func loadMeal() {
        if let price =  meal["price"] {
            lbTotal.text = "$\(price)"
        }
    }
    
    
    
    
    
    @IBAction func addQtyMeal(_ sender: Any) {
        if qty < 99 {
            qty += 1
            lbQty.text = String(qty)
            
            if let price = meal["price"] {
                lbTotal.text = "$\(price as! Float * Float(qty))"
            }
        }
    }
    
    
    @IBAction func removeQtyMeal(_ sender: Any) {
        if qty >= 2 {
            qty -= 1
            lbQty.text = String(qty)
            
            if let price = meal["price"] {
                lbTotal.text = "$\(price as! Float * Float(qty))"
            }
        }
    }
    

    @IBAction func addToCart(_ sender: Any) {
        // create an animation when click on add to cart
        
        //
//        let cartItem = CartItem(meal: self.meal["meal"] as! Meal, qty: qty)
//        guard let cartRestaurant = Cart.currentCart.restaurant, let currentRestaurant = self.restaurant
//        else {
//            Cart.currentCart.restaurant = self.restaurant["restaurant"] as? Restaurant
//            Cart.currentCart.items.append(cartItem)
//            return
//        }
//
//        //
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        if cartRestaurant.id == currentRestaurant.id{
//            let inCart = Cart.currentCart.items.firstIndex(where: { (item) -> Bool in
//                return item.meal.id! == cartItem.meal.id!
//            })
//
//            if let index = inCart {
//                let alertView = UIAlertController (
//                    title: "Add more",
//                    message: "You already have this item in your cart. Do you want to add more?",
//                    preferredStyle: .alert)
//
//                let okAction = UIAlertAction(title: "Add more", style: .default, handler: {(action: UIAlertAction!) in
//                    Cart.currentCart.items[index].qty += self.qty
//
//             })
//                alertView.addAction(okAction)
//            }
//        }else{
//
//        }
    }
    
    //
    
    
//END of Class
}
