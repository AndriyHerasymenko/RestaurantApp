//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by Andriy Herasymenko on 3/26/17.
//  Copyright © 2017 Andriy Herasymenko. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name: String
    var type: String
    var location: String
    var image: String
    var isVisited: Bool
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
    
}
