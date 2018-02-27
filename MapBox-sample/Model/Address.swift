//
//  Address.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 24/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class Address: NSObject, NSCoding {
    var streetNumber: String?
    var streetName: String?
    var postalCode: String?
    var town: String?
    var printableAddress: String?
    var coordinate: Coordinate

    private struct SerializationKeys {
        static let streetNumber = "streetNumber"
        static let streetName = "streetName"
        static let postalCode = "postalCode"
        static let town = "town"
        static let printableAddress = "printableAddress"
        static let coordinate = "coordinate"
    }
    
    init(streetNumber: String?, streetName: String?, postalCode: String?, town: String?, printableAddress: String?, coordinate: Coordinate) {
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.postalCode = postalCode
        self.town = town
        self.printableAddress = printableAddress
        self.coordinate = coordinate
    }
    
    init(mapBoxDic: [String: Any], coordinate: Coordinate, printableAddress: String) {
        struct SerializeKeys {
            private init() {}
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
        aCoder.encode(self.streetNumber, forKey: SerializationKeys.streetNumber)
        aCoder.encode(self.streetName, forKey: SerializationKeys.streetName)
        aCoder.encode(self.postalCode, forKey: SerializationKeys.postalCode)
        aCoder.encode(self.town, forKey: SerializationKeys.town)
        aCoder.encode(self.printableAddress, forKey: SerializationKeys.printableAddress)
        aCoder.encode(self.coordinate, forKey: SerializationKeys.coordinate)

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.streetNumber = aDecoder.decodeObject(forKey: SerializationKeys.streetNumber) as? String
        self.streetName = aDecoder.decodeObject(forKey: SerializationKeys.streetName) as? String
        self.postalCode = aDecoder.decodeObject(forKey: SerializationKeys.postalCode) as? String
        self.town = aDecoder.decodeObject(forKey: SerializationKeys.town) as? String
        self.printableAddress = aDecoder.decodeObject(forKey: SerializationKeys.printableAddress) as? String
        self.coordinate = aDecoder.decodeObject(forKey: SerializationKeys.coordinate) as! Coordinate

    }
    
    static func ==(lhs: Address, rhs: Address) -> Bool {
        return lhs.streetName == rhs.streetName
            && lhs.streetNumber == rhs.streetNumber
            && lhs.postalCode == rhs.postalCode
            && lhs.printableAddress == rhs.printableAddress
            && lhs.town == rhs.town
            && lhs.coordinate == rhs.coordinate
    }

}

extension Address {
    var formattedAddress: String {
        get {
            let formattedString = [self.streetNumber, self.streetName, self.postalCode, self.town].flatMap({$0}).joined(separator: ", ")
            return formattedString.isEmpty ? (self.printableAddress ?? "") : formattedString
        }
    }
}

extension Array where Element : Address {

    @discardableResult mutating func add(address: Address, maxElements: Int) -> [Address] {
        var filteredAddresses: [Address] = self.filter({$0.coordinate.latitude != address.coordinate.latitude || $0.coordinate.longitude != address.coordinate.longitude})
        if filteredAddresses.count < maxElements {
            filteredAddresses.append(address)
        } else {
            filteredAddresses.remove(at: 0)
            filteredAddresses.append(address)
        }
        self = filteredAddresses as! [Element]
        return filteredAddresses
    }

}
