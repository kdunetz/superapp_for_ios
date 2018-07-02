//
//  Artwork.swift
//  SuperApp
//
//  Created by Kevin Dunetz on 6/4/18.
//  Copyright © 2018 Kevin Dunetz. All rights reserved.
//

import Foundation
import MapKit

class UserObject: NSObject, MKAnnotation {
    let username: String
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(username: String, title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.username = username
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}


