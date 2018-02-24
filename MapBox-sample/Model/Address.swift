//
//  Address.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class Address {
    var streetNumber: String?
    var streetName: String?
    var postalCode: String?
    var town: String?
    var printableAddress: String?
    var coordinate: Coordinate?
    
    init(streetNumber: String?, streetName: String?, postalCode: String?, town: String?, printableAddress: String?, coordinate: Coordinate?) {
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.postalCode = postalCode
        self.town = town
        self.printableAddress = printableAddress
        self.coordinate = coordinate
    }
    
    init(mapBoxDic: [String: Any], coordinate: Coordinate, printableAddress: String) {
        struct SerializeKeys {
            private init(){}
            static let streetNumber = "subThoroughfare"
            static let streetName = "street"
            static let postalCode = "postalCode"
            static let town = "subAdministrativeArea"
        }
        self.coordinate = coordinate
        self.printableAddress = printableAddress
        self.streetNumber = mapBoxDic[SerializeKeys.streetNumber] as? String
        self.streetName = mapBoxDic[SerializeKeys.streetName] as? String
        self.postalCode = mapBoxDic[SerializeKeys.postalCode] as? String
        self.town = mapBoxDic[SerializeKeys.town] as? String
    }
    
    convenience init(mapBoxDic: [String: Any], coordinate: CLLocation, printableAddress: String) {
        self.init(mapBoxDic: mapBoxDic, coordinate: Coordinate(location: coordinate), printableAddress: printableAddress)
    }
    
}
