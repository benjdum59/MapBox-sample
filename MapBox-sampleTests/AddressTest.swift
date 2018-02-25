//
//  AddressTest.swift
//  MapBox-sampleTests
//
//  Created by Benjamin DUMONT on 25/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import XCTest
import CoreLocation

class AddressTest: XCTestCase {
    let streetNumber = "fakeNumber"
    let streetName = "fakeName"
    let postalCode = "fakePostalCode"
    let town = "fakeTown"
    let printableAddress = "fakePrintable"
    let coordinate = Coordinate(latitude: 0, longitude: 0)
    var address: Address!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        address = Address(streetNumber: streetNumber, streetName: streetName, postalCode: postalCode, town: town, printableAddress: printableAddress, coordinate: coordinate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitAddressFromMapBox() {
        struct SerializeKeys {
            private init(){}
            static let streetNumber = "subThoroughfare"
            static let streetName = "street"
            static let postalCode = "postalCode"
            static let town = "subAdministrativeArea"
        }
        
        let mapBoxDic = [
            SerializeKeys.streetNumber: streetNumber,
            SerializeKeys.streetName: streetName,
            SerializeKeys.postalCode: postalCode,
            SerializeKeys.town: town
        ]
        let mapBoxDicError = [
            SerializeKeys.streetNumber: "error",
            SerializeKeys.streetName: streetName,
            SerializeKeys.postalCode: postalCode,
            SerializeKeys.town: town
        ]
        let address2 = Address(mapBoxDic: mapBoxDic, coordinate: coordinate, printableAddress: printableAddress)
        let address3 = Address(mapBoxDic: mapBoxDic, coordinate: coordinate, printableAddress: "error")
        let address4 = Address(mapBoxDic: mapBoxDic, coordinate: Coordinate(latitude: 1, longitude: 0), printableAddress: printableAddress)
        let address5 = Address(mapBoxDic: mapBoxDic, coordinate: Coordinate(latitude: 0, longitude: 1), printableAddress: printableAddress)
        let address6 = Address(mapBoxDic: mapBoxDicError, coordinate: coordinate, printableAddress: printableAddress)

        XCTAssertTrue(address == address2, "Addresses should be the same")
        XCTAssertFalse(address == address3, "Addresses should not be the same, printableAddress differs")
        XCTAssertFalse(address == address4, "Addresses should not be the same, latitude differs")
        XCTAssertFalse(address == address5, "Addresses should not be the same, longitude differs")
        XCTAssertFalse(address == address6, "Addresses should not be the same, mapBoxDic differs")
    }
    
    func testFormattedAddress(){
        XCTAssertTrue(address.formattedAddress == streetNumber + ", " + streetName + ", " + postalCode + ", " + town)
        XCTAssertFalse(address.formattedAddress == streetNumber + ", " + streetName + ", " + postalCode)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
