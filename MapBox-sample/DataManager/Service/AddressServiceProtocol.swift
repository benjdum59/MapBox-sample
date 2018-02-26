//
//  AddressServiceProtocol.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

protocol AddressServiceProtocol {
    func searchAddresses(string: String, completion:@escaping ([Address]) -> Void)
    func getAddress(coordinate:CLLocationCoordinate2D, completion:@escaping (Address?) -> Void)
}
