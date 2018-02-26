//
//  SearchAddressTestCase.swift
//  MapBox-sampleUITests
//
//  Created by Benjamin DUMONT on 26/02/2018.
//  Copyright © 2018 Benjamin DUMONT. All rights reserved.
//

import XCTest

class SearchAddressTestCase: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        XCTAssertTrue(waitForObjectExists(app.searchFields.element))

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testView() {
        app.searchFields.element.tap()
        XCTAssertTrue(waitForObjectExists(app.buttons["Cancel"]))
        let initialCellNumber = app.tables.element.cells.count
        XCTAssertTrue(initialCellNumber <= 2, "TableView should have less than 2 cells (the 2 cells are for history)")
        app.searchFields.element.typeText("a")
        wait(2, reason: "Call the API")
        XCTAssertTrue(app.tables.element.cells.count > initialCellNumber, "TableView should have more cells")
        app.tables.element.cells.firstMatch.tap()
        MapViewControllerTestCase().testView()
    }
}
