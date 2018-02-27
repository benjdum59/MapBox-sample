//
//  AddressHistoryMock.swift
//  MapBox-sample
//
//  Created by Benjamin DUMONT on 26/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import Foundation

class AddressHistoryMock: AddressStorageProtocol {
    let address1 = Address(streetNumber: "fakeNumber1", streetName: "fakeName1", postalCode: "fakePostalCode1", town: "fakeTown1", printableAddress: "fakePrint1", coordinate: Coordinate(latitude: 0, longitude: 0))
    let address2 = Address(streetNumber: "fakeNumber2", streetName: "fakeName2", postalCode: "fakePostalCode2", town: "fakeTown2", printableAddress: "fakePrint2", coordinate: Coordinate(latitude: 0, longitude: 1))
    var getAddressesCalled = false
    var saveAddressesCalled = false

    func getAddresses(completion: ([Address]) -> Void) {
        getAddressesCalled = true
        completion([address1, address2])
    }
    
    func saveAddresses(addresses: [Address], completion: () -> Void) {
        saveAddressesCalled = true
        completion()
    }
    
    
}
