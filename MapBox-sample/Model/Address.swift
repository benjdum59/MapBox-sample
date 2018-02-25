//
//  Address.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class Address: NSCoding {
    
    var streetNumber: String?
    var streetName: String?
    var postalCode: String?
    var town: String?
    var printableAddress: String?
    var coordinate: Coordinate?
    
    private struct SerializationKeys {
        static let streetNumber = "streetNumber"
        static let streetName = "streetName"
        static let postalCode = "postalCode"
        static let town = "town"
        static let printableAddress = "printableAddress"
        static let coordinate = "coordinate"
    }
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(streetNumber, forKey: SerializationKeys.streetNumber)
        aCoder.encode(streetName, forKey: SerializationKeys.streetName)
        aCoder.encode(postalCode, forKey: SerializationKeys.postalCode)
        aCoder.encode(town, forKey: SerializationKeys.town)
        aCoder.encode(printableAddress, forKey: SerializationKeys.printableAddress)
        aCoder.encode(coordinate, forKey: SerializationKeys.coordinate)

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.streetNumber = aDecoder.decodeObject(forKey: SerializationKeys.streetNumber) as? String
        self.streetName = aDecoder.decodeObject(forKey: SerializationKeys.streetName) as? String
        self.postalCode = aDecoder.decodeObject(forKey: SerializationKeys.postalCode) as? String
        self.town = aDecoder.decodeObject(forKey: SerializationKeys.town) as? String
        self.printableAddress = aDecoder.decodeObject(forKey: SerializationKeys.printableAddress) as? String
        self.coordinate = aDecoder.decodeObject(forKey: SerializationKeys.coordinate) as? Coordinate

    }
    
}

extension Address {
    var formattedAddress: String {
        get{
            let formattedString = [self.streetNumber, self.streetName, self.postalCode, self.town].flatMap({$0}).joined(separator: ", ")
            return formattedString.isEmpty ? (self.printableAddress ?? "") : formattedString
        }
    }
}
