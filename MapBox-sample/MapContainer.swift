//
//  MapContainer.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class MapContainer {
    var map: MapProtocol

    init(map: MapProtocol){
        self.map = map
    }

    func showLocation(location: CLLocationCoordinate2D) {
        map.showLocation(location: location)
    }

}
