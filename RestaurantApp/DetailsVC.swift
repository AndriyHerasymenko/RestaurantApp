//
//  DetailsVC.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 3/27/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    
//    var fetchResultController: NSFetchedResultsController<Restaurant>!
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? RateVC else { return }
        guard let rating = svc.restRating else { return }
        rateBtn.setImage(UIImage(named: rating), for: .normal)
    }
    
    var restaurant: Restaurant?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        let buttons = [rateBtn, mapBtn]
        
        for button in buttons {
            guard let button = button else { return }
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableViewAutomaticDimension
        
        imageView.image = UIImage(data: restaurant!.image! as Data)
        
        tableView.tableFooterView = UIView(frame: .zero)
        title = restaurant!.name
        
//        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
//            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//            
//            do {
//                try fetchResultController.performFetch()
//                //rateBtn = fetchResultController.fetchedObjects!
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        
        switch indexPath.row {
        case 0:
            cell.keyLbl.text = "Name"
            cell.valueLbl.text = restaurant!.name
        case 1:
            cell.keyLbl.text = "Type"
            cell.valueLbl.text = restaurant!.type
        case 2:
            cell.keyLbl.text = "Address"
            cell.valueLbl.text = restaurant!.location
        case 3:
            cell.keyLbl.text = "Did I eat here?"
            cell.valueLbl.text = restaurant!.isVisited ? "Yes" : "No"
        default: break
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let destinationVC = segue.destination as! MapVC
            destinationVC.restaurant = restaurant
        }
    }
    
    
}
