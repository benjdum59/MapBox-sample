//
//  Coordinate.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class Coordinate: NSCoding{
    
    let latitude: Double
    let longitude: Double
    
    private struct SerializationKeys {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: SerializationKeys.latitude)
        aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as! Double
        self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as! Double

    }
}

