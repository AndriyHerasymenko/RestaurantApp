//
//  RateVC.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 3/28/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit

class RateVC: UIViewController {
    
    @IBOutlet weak var badBtn: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var brilliantBtn: UIButton!
    
    var restRating: String?
    
    @IBAction func rateRestaurant(sender: UIButton) {
        
        switch sender.tag {
        case 0: restRating = "bad"
        case 1: restRating = "good"
        case 2: restRating = "brilliant"
        default: break
        }
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            let restaurant = Restaurant(context: context)
            restaurant.rate = restRating
            
            do {
                try context.save()
                print("Rating saved")
            } catch let error as NSError {
                print("Cant sve rating \(error), \(error.userInfo)")
            }
        }
        
        performSegue(withIdentifier: "unwindSegueToDVC", sender: sender)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let buttonArray = [badBtn, goodBtn, brilliantBtn]
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        badBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        brilliantBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.insertSubview(blurEffectView, at: 1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
