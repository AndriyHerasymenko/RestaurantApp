//
//  NewRestaurantTableVC.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 4/2/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit

class NewRestaurantTableVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var typeTxtField: UITextField!
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    var isVisited = false
    
    @IBAction func switchIsVisitedPressed(_ sender: UIButton) {
        if sender == yesBtn {
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            noBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            isVisited = true
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            yesBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            isVisited = false
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        
        var missedField = ""
        
        if nameTxtField.text == "" {
            missedField = "name"
        } else if locationTxtField.text == "" {
            missedField = "location"
        } else if typeTxtField.text == "" {
            missedField = "type"
        }
        
        if missedField != "" {
            let alertController = UIAlertController(title: "Sorry", message: "You forgot to fill in the restaurant \(missedField)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(ok)
            
            present(alertController, animated: true, completion: nil)
        } else {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let restaurant = Restaurant(context: context)
                restaurant.name = nameTxtField.text
                restaurant.location = locationTxtField.text
                restaurant.type = typeTxtField.text
                restaurant.isVisited = isVisited
                if let image = imageView.image {
                    restaurant.image = UIImagePNGRepresentation(image) as NSData?
                }
                
                do {
                    try context.save()
                    print("Data saved!")
                } catch let error as NSError {
                    print("Coudn't save data \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindSegueFromNewRest", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let font = UIFont(name: "AvenirNext-Regular", size: 18) {
            saveBtn.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
            cancelBtn.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let alertController = UIAlertController(title: "Source of Picture", message: nil, preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                self.chooseImgPickerAction(source: .camera)
            })
            
            let photoLibAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (action) in
                self.chooseImgPickerAction(source: .photoLibrary)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(cameraAction)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func chooseImgPickerAction(source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source



    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
