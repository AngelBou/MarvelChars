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
        configureApp(json: "Spiderman")
        app.launch()
        
        listScreenIsShown()
    }

    func testCharListNavigateToDetailWhenTapOnItem() throws {
        
        configureApp(json: "Loki")
        app.launch()
        
        let name = "Loki"
        // When
        listScreenIsShown()

        // When Tap in cell of "Loki"
        tapCell(name: name)

        // Then navigate to Detail of char "Loki"
        detailScreenIsShown(with: name)
    }
    
    func testNavigationFromListToDetail() {
        configureApp(json: "Spiderman")
        app.launch()
        
        // Given
        listScreenIsShown()

        // When
        tapCell(row: 0)

        // Then
        detailScreenIsShown()
    }
    
    func testNavigationFromDetailBackToList() {
        configureApp(json: "GamoraSearch")
        app.launch()
        
        // Given
        listScreenIsShown()

        // When
        tapCell(row: 1)
        detailScreenIsShown()
        tapBackButton()

        listScreenIsShown()
    }
    
    func testErrorPopUpShownWithNetworkError() {
        configureApp(networkError: "failure")
        app.launch()
        
        // Given
        listScreenIsShown()
        
        errorAlertIsShown()
        
        tapOkButtonErrorAlert()
    }
        
    // Test with call to service
    // NOTE this test can fail depending on the result given by the server
    func testCharListNavigateToDetailWhenTapOnTestServer() throws {
        
        configureApp(fakeData: "no")
        app.launch()
        
        let name = "Abyss (Age of Apocalypse)"
        // When
        listScreenIsShown()

        // When Tap in cell of "Abyss (Age of Apocalypse)"
        tapCell(name: name)

        // Then navigate to Detail of char "Abyss (Age of Apocalypse)"
        detailScreenIsShown(with: name)
    }
    
    func testShowDetail() {
        configureApp(initialScene: "CharDetail")
        app.launch()
        
        detailScreenIsShown()
        
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
    
    func configureApp(fakeData: String? = "yes",
                      json: String? = nil,
                      networkError: String? = nil,
                      initialScene: String? = nil) {
        
        var environment: [String: String] = [:]
        environment["fakeData"] = fakeData
        
        environment["charactersServiceJsonName"] = json
        environment["charactersServiceError"] = networkError
        
        environment["initialScene"] = initialScene
        
        app.launchEnvironment = environment
    }

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
    
    func errorAlertIsShown() {
        XCTAssertEqual(app.alerts.element.label, "Error")
    }
    
    func tapOkButtonErrorAlert() {
        app.alerts["Error"].buttons["Ok"].tap()
    }
    
}
