//
//  RestaurantTableVC.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 3/26/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    var restaurants: [Restaurant] = []
//        Restaurant(name: "Coya", type: "Latin American", location: "Four Seasons Resort Jumeirah Beach Road", image: "ogonek.jpg", isVisited: false),
//        Restaurant(name: "Play Restaurant&Lounge", type: "Bar Food", location: "The H Dubai - Sheikh Zayed Road", image: "elu.jpg", isVisited: false),
//        Restaurant(name: "Pai Thai", type: "Thai,South East Asian", location: "Al Qasr Hotel, Madinat Jumeirah - Umm Suqeim", image: "bonsai.jpg", isVisited: false),
//        Restaurant(name: "The Hide", type: "American,Steakhouses", location: "Al Qasr Hotel, Madinat Jumeirah - Umm Suqeim", image: "dastarhan.jpg", isVisited: false),
//        Restaurant(name: "Nusr-Et", type: "Turkish", location: "Four Seasons Resort Dubai at Jumeirah Beach - Jumeirah", image: "indokitay.jpg", isVisited: false),
//        Restaurant(name: "Zuma", type: "Japanese", location: "DIFC", image: "x.o.jpg", isVisited: false),
//        Restaurant(name: "Solo Bistronomia", type: "Italian", location: "Raffles Dubai - Oud Metha", image: "balkan.jpg", isVisited: false),
//        Restaurant(name: "Rang Mahal", type: "Indian", location: "JW Marriott Marquis Hotel Dubai - Sheikh Zayed Road", image: "respublika.jpg", isVisited: false),
//        Restaurant(name: "La Petite Maison", type: "French", location: "DIFC", image: "speakeasy.jpg", isVisited: false),
//        Restaurant(name: "BOCA", type: "Mediterranean", location: "DIFC", image: "morris.jpg", isVisited: false),
//        Restaurant(name: "Hakkasan", type: "Chinese", location: "Jumeirah Emirates Towers - Sheikh Zayed Road", image: "istorii.jpg", isVisited: false),
//        Restaurant(name: "Mekong", type: "Asian,South East Asian", location: "Anantara Dubai The Palm Resort & Spa - Palm Jumeirah", image: "klassik.jpg", isVisited: false),
//        Restaurant(name: "JW’s Steakhouse", type: "Steakhouses", location: "JW Marriott Dubai - Deira", image: "love.jpg", isVisited: false),
//        Restaurant(name: "Ossiano", type: "Seafood", location: "Atlantis The Palm - Palm Jumeirah", image: "shok.jpg", isVisited: false),
//        Restaurant(name: "At.mosphere", type: "European,Steakhouses", location:  "Downtown Dubai", image: "bochka.jpg", isVisited: false)]
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Fetch Result Controller Delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
   
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        
        cell.mainImgView.image = UIImage(data: restaurants[indexPath.row].image as! Data)
        cell.mainImgView.layer.cornerRadius = 32.5
        cell.mainImgView.clipsToBounds = true
        
        cell.nameLbl.text = restaurants[indexPath.row].name
        cell.typeLbl.text = restaurants[indexPath.row].type
        cell.locationLbl.text = restaurants[indexPath.row].location
        
        cell.accessoryType = self.restaurants[indexPath.row].isVisited ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultText = "I'm in " + self.restaurants[indexPath.row].name!
            if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPAth) in
            self.restaurants.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                let objectToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(objectToDelete)
                do {
                    try context.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [delete, share]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! DetailsVC
                destinationVC.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
    
    

    
}
