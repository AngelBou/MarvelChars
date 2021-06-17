//
//  MarvelCharsUITests.swift
//  MarvelCharsUITests
//
//  Created by Angel Boullon on 15/06/2021.
//

import XCTest

class MarvelCharsUITests: XCTestCase {

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
    
    func testStartingFromHomeScreen() {
        app.launch()
        
        listScreenIsShown()
    }

    func testCharListNavigateToDetailWhenTapOnItem() throws {
        
        app.launch()
        
        let name = "A.I.M."
        // When
        listScreenIsShown()

        // When Tap in cell of "A.I.M."
        tapCell(name: name)

        // Then navigate to Detail of char "A.I.M."
        detailScreenIsShown(with: name)
    }
    
    func testNavigationFromListToDetail() {
        app.launch()
        
        // Given
        listScreenIsShown()

        // When
        tapCell(row: 0)

        // Then
        detailScreenIsShown()
    }
    
    func testNavigationFromDetailBackToList() {
        app.launch()
        
        // Given
        listScreenIsShown()

        // When
        tapCell(row: 1)
        detailScreenIsShown()
        tapBackButton()

        listScreenIsShown()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension MarvelCharsUITests {

    // MARK: - Actions
    func tapCell(row: Int) {
        let accessibilityLabel = "Cell_" + String(row)
        app.cells[accessibilityLabel].tap()
    }

    func tapCell(name: String) {
        let accesibilityLabel = "name_\(name)"
        app.tables.staticTexts[accesibilityLabel].tap()
    }

    func tapBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    func listScreenIsShown() {
        XCTAssert(app.navigationBars["MARVEL Characters"].exists)
    }

    func detailScreenIsShown() {
        XCTAssertTrue(app.otherElements["Detail screen"].exists)
    }

    func detailScreenIsShown(with name: String) {
        XCTAssert(app.navigationBars[name].exists)
    }
}
