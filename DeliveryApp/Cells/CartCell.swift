//
//  CartCell.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit

class CartCell: UITableViewCell {
    
    
    @IBOutlet weak var cartMealQuantityLabel: UILabel!
    
    @IBOutlet weak var cartMealTitleLabel: UILabel!
    
    @IBOutlet weak var cartMealPriceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
