//
//  RestaurantsViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 10/29/21.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    //Variable availble in the lifetime of the screen
    var restaurants = [[String:Any]]()
    

    //search results
    //var filteredRestaurants = [restaurants]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // start calling api
        let url = URL(string: "https://fooddeliverynowapp.herokuapp.com/api/customer/restaurants/")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                 
                 self.restaurants = dataDictionary["restaurants"] as! [[String:Any]]
                 self.tableView.reloadData()
                 //download is complete : reload table view data
                 self.tableView.reloadData()
                 print(dataDictionary)
             }
        }
        task.resume()

      
        //end of function
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurants[indexPath.row]
        let restaurantName = restaurant["name"] as! String
        let restaurantAddress = restaurant["address"] as! String
        let restaurantPhone = restaurant["phone"] as! String
        
        cell.restaurantName.text = restaurantName
        cell.restaurantAddress.text = restaurantAddress
        cell.restaurantPhone.text = restaurantPhone
//
        
        //Displaying image
//      
        let restaurantPath = restaurant["logo"] as! String
        let mealUrl = URL(string: restaurantPath)
        
        cell.restaurantPicture.af.setImage(withURL: mealUrl!)

        
        
        return cell
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //print("Loading details")
        
        //find selcted meal
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let restaurant = restaurants[indexPath.row]
        
        
        //pas the selected meal to the details screen
        let detailsViewController = segue.destination as! ResturantDetailsViewController
        detailsViewController.restaurant = restaurant
        
        //deselecting after click on individual meal
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    
//end
}
