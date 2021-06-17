//
//  MarvelCharsUITestsNoServer.swift
//  MarvelCharsUITests
//
//  Created by Angel Boullon on 17/06/2021.
//

import XCTest

class MarvelCharsUITestsNoServer: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The setUp method is a good place to do this.
        try super.setUpWithError()
        
        self.app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrorPopUpShownWithNetworkError() {
        app.launch()
        
        // Given
        listScreenIsShown()
        
        errorAlertIsShown()
        
        tapOkButtonErrorAlert()
    }
    
    func listScreenIsShown() {
        XCTAssert(app.navigationBars["MARVEL Characters"].exists)
    }
    
    func errorAlertIsShown() {
        XCTAssertEqual(app.alerts.element.label, "Error", "Alert must be shown")
    }
    
    func tapOkButtonErrorAlert() {
        app.alerts["Error"].buttons["Ok"].tap()
    }

}
