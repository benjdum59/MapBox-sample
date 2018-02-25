//
//  MapProtocole.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapProtocol {
    init(view: UIView, delegate: Any?)
    func showLocation(location: CLLocationCoordinate2D)
}
