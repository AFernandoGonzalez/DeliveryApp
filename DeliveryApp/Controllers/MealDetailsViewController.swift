//
//  MealDetailsViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var mealDetailName: UILabel!
    
    @IBOutlet weak var mealDetailDescriptionLabel: UILabel!
    
    @IBOutlet weak var mealDeatilPriceLabel: UILabel!
    
    
    
    var meal: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mealDetailName.text = meal["name"] as? String
        mealDetailDescriptionLabel.text = meal["short_description"] as? String
        
        
        //Displaying image
        let mealPath = meal["image"] as! String
        let mealUrl = URL(string: mealPath)
        
        mealImageView.af.setImage(withURL: mealUrl!)
        
    

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
