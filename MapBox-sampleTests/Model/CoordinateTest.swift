//
//  CoordinateTest.swift
//  MapBox-sampleTests
//
//  Created by Benjamin DUMONT on 27/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import XCTest
import CoreLocation

class CoordinateTest: XCTestCase {
    var coordinate: Coordinate!
    let longitude = 12.0
    let latitude = 24.0
    var location: CLLocation!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinate = Coordinate(latitude: latitude, longitude: longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertTrue(coordinate.latitude == latitude)
        XCTAssertTrue(coordinate.longitude == longitude)
    }
    
    func testInitCLLocation(){
        let locationCoordinate = Coordinate(location: location)
        XCTAssertTrue(locationCoordinate.latitude == latitude)
        XCTAssertTrue(locationCoordinate.longitude == longitude)
        XCTAssertTrue(locationCoordinate == coordinate)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
