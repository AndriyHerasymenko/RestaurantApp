//
//  DetailCell.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 3/27/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var keyLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
