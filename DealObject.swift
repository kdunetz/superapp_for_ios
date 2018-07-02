//
//  DealObject.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/30/18.
//  Copyright © 2018 Kevin Dunetz. All rights reserved.
//

import Foundation
//
//  LocationObject.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/29/18.
//  Copyright © 2018 Kevin Dunetz. All rights reserved.
//
import Foundation
import MapKit

class DealObject: NSObject, MKAnnotation {
    let title: String?
    let type: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, type: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.type = type
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return "" // locationName
    }
}

