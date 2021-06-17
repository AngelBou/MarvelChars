//
//  UtilsTests.swift
//  MarvelChars
//
//  Created by Angel Boullon on 13/06/2021.
//

import XCTest
@testable import MarvelChars

class UtilsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMD5() {
        // Given
        let testString = "Hello"

        // When
        let md5HexString = Utils.MD5(testString)

        // Then
        XCTAssertEqual(md5HexString, "8b1a9953c4611296a827abf8c47804d7", "MD5 of 'Hello' string must be 8b1a9953c4611296a827abf8c47804d7")

    }

}
