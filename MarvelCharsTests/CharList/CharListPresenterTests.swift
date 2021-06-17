//
//  CharListPresenterTests.swift
//  MarvelCharsTests
//
//  Created by Angel Boullon on 12/06/2021.
//

import XCTest
@testable import MarvelChars

class CharListPresenterTests: XCTestCase {

    var sut: CharListPresenter!

    var interactorSpy: CharListInteractorSpy!
    var viewSpy: CharListViewControllerSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        interactorSpy = CharListInteractorSpy()
        viewSpy = CharListViewControllerSpy()

        sut = CharListPresenter()
        sut.interactor = interactorSpy
        sut.view = viewSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenViewLoadedPresentThenPresenterCallsInteractorTogetCharacters() {
        // Given

        // When
        sut.viewLoaded()

        // Then
        XCTAssert(interactorSpy.getCharactersCalled, "Must call to interactor to getCharactersCalled")
    }

    func testWhenPresentCharactersCalledThenPresenterCallsViewToDisplayCharacters() {
        // Given
        sut.characters = []
        let char1 = Character(id: 0, name: "name")
        let char2 = Character(id: 1, name: "name2")
        
        let charsFromInteractor = [char1, char2]

        // When
        sut.presentCharacters(charsFromInteractor)

        // Then
        XCTAssertEqual(sut.characters, charsFromInteractor, "Character saved in presenter are equal to presentCharacters parameter")
        XCTAssert(viewSpy.displayCharactersCalled, "Must call to view to displayCharacters")
    }
}

class CharListInteractorSpy: CharListInteractorInputProtocol {

    var presenter: CharListPresenterOutputProtocol?
    var apiManager: ApiManager?

    var getCharactersCalled: Bool = false
    var getMoreCharactersCalled: Bool = false

    func getCharacters() {
        getCharactersCalled = true
    }

    func getMoreCharacters() {
        getMoreCharactersCalled = true
    }
}

class CharListViewControllerSpy: CharListViewControllerProtocol {
    var presenter: CharListPresenterInputProtocol?

    var navigationController: UINavigationController?

    var refreshCalled: Bool = false
    var displayCharactersCalled: Bool = false
    var displayErrorCalled: Bool = false
    var displayMessageCalled: Bool = false

    func refresh() {
        refreshCalled = true
    }

    func displayCharacters(_ characters: [Character]) {
        displayCharactersCalled = true
    }

    func displayError(_ error: Error) {
        displayErrorCalled = true
    }

    func displayMessage(_ message: String, title: String) {
        displayMessageCalled = true
    }
}
