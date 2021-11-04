//
//  CartViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 11/1/21.
//

import UIKit
import MapKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //cart deatails
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewaddress: UIView!
    @IBOutlet weak var viewMap: UIView!
    
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelAddress: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var addPaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        
        let lbEmptyCart = UILabel(frame: CGRect(x: 100, y: 200, width: 220, height: 50))
        lbEmptyCart.text = "Your Tray is Empty";
        view.addSubview(lbEmptyCart)
    
        
        //Empty Cart
//        if Cart.currentCart.items.count == 0 {
//            let lbEmptyCart = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
//            lbEmptyCart.center = self.view.center
//            lbEmptyCart.textAlignment = NSTextAlignment.center
//            lbEmptyCart.text = "Your Tray is Empty"
//        }else {
//            self.tableView.isHidden = false
//            self.viewTotal.isHidden = false
//            self.viewaddress.isHidden = false
//            self.addPaymentButton.isHidden = false
//
//
//        }
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        
        return cell
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
