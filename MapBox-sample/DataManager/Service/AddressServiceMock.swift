//
//  AddressServiceMock.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 26/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation
import CoreLocation

class AddressServiceMock: AddressServiceProtocol {
    let address1 = Address(streetNumber: "fakeNumber1", streetName: "fakeName1", postalCode: "fakePostalCode1", town: "fakeTown1", printableAddress: "fakePrint1", coordinate: Coordinate(latitude: 0, longitude: 0))
    let address2 = Address(streetNumber: "fakeNumber2", streetName: "fakeName2", postalCode: "fakePostalCode2", town: "fakeTown2", printableAddress: "fakePrint2", coordinate: Coordinate(latitude: 0, longitude: 1))
    
    var searchAddressesCalled = false
    var getAddressCalled = false
    
    
    
    func searchAddresses(string: String, completion: @escaping ([Address]) -> Void) {
        searchAddressesCalled = true
        completion([address1, address2])
    }
    
    func getAddress(coordinate: CLLocationCoordinate2D, completion: @escaping (Address?) -> Void) {
        getAddressCalled = true
        completion(address1)
    }
    
    
}
