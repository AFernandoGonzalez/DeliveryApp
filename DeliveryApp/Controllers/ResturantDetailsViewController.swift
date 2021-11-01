//
//  ResturantDetailsViewController.swift
//  DeliveryApp
//
//  Created by Alvaro Gonzalez on 10/29/21.
//

import UIKit
import AlamofireImage

class ResturantDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //Variable availble in the lifetime of the screen
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var meals = [[String:Any]]()
    
    var restaurant: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // start calling api
        let url = URL(string: "https://fooddeliverynowapp.herokuapp.com/api/customer/meals/1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                 
                 self.meals = dataDictionary["meals"] as! [[String:Any]]
                 
                 self.tableView.reloadData()
                 
                 
                 //download is complete : reload table view data
                 self.tableView.reloadData()
                 
                 print(dataDictionary)

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        
        
        //print(restaurant["name"])

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell") as! MealCell
        
        let meal = meals[indexPath.row]
        let mealname = meal["name"] as! String
        let mealdescription = meal["short_description"] as! String
        //let mealprice = meal["price"] as! Int
        
    
        cell.mealNameLabel.text = mealname
        cell.mealDescriptionLabel.text = mealdescription
        //cell.mealDescriptionLabel
        
        
        //Displaying image
        let mealPath = meal["image"] as! String
        let mealUrl = URL(string: mealPath)
        
        cell.mealPicture.af.setImage(withURL: mealUrl!)
    
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        //find selcted meal
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let meal = meals[indexPath.row]
        
        
        //pas the selected meal to the details screen
        let detailsViewController = segue.destination as! MealDetailsViewController
        detailsViewController.meal = meal
        
        //deselecting after click on individual meal
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
