//
//  BLLTests.swift
//  MapBox-sampleTests
//
//  Created by Benjamin DUMONT on 26/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import XCTest
import CoreLocation

class BLLTests: XCTestCase {
    var addressBLL: AddressBLL!
    var storage: AddressHistoryMock!
    var service: AddressServiceMock!
    override func setUp() {
        super.setUp()
        storage = AddressHistoryMock()
        service = AddressServiceMock()
        addressBLL = AddressBLL(storage: storage, service: service)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetAddressHistory() {
        let readyExpectation = self.expectation(description: "testGetAddressHistory")
        addressBLL.getAddressHistory { (addresses) in
            XCTAssertTrue(addresses.count == 2, "Array should have 2 elements")
            XCTAssertTrue(addresses.first == storage.address1, "1st element of array should be address1")
            XCTAssertTrue(addresses.last == storage.address2, "last element of array should be address2")
            readyExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Error")
        }
        XCTAssertTrue(storage.getAddressesCalled, "Method getAddresses should be called")
    }
    
    func testSaveAddress() {
        let readyExpectation = self.expectation(description: "testSaveAddress")
        addressBLL.saveAddress(address: storage.address1) {
            readyExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Error")
        }
        XCTAssertTrue(storage.saveAddressesCalled, "Method saveAddresses should be called")
    }
    
    func testSearchAddress(){
        let readyExpectation = self.expectation(description: "testSearchAddress")
        addressBLL.searchAddress(string: "none") { (addresses) in
            XCTAssertTrue(addresses.count == 2, "Array should have 2 elements")
            XCTAssertTrue(addresses.first == self.service.address1, "1st element of array should be address1")
            XCTAssertTrue(addresses.last == self.service.address2, "last element of array should be address2")
            
            readyExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Error")
        }
        XCTAssertTrue(service.searchAddressesCalled, "Method searchAddresses should be called")
    }
    
    func testGetAddress(){
        let readyExpectation = self.expectation(description: "testGetAddress")
        addressBLL.getAddress(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)) { (address) in
            XCTAssertNotNil(address, "Address should not be nil")
            XCTAssertTrue(address == self.service.address1, "Address should be equal to address1")
            
            readyExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Error")
        }
        XCTAssertTrue(service.getAddressCalled, "Method getAddress should be called")
        XCTAssertTrue(storage.saveAddressesCalled, "Method saveAddresses should be called")
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
