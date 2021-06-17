//
//  CharListInteractorTests.swift
//  MarvelCharsTests
//
//  Created by Angel Boullon on 12/06/2021.
//

// swiftlint:disable trailing_whitespace

import XCTest
@testable import MarvelChars

class CharListInteractorTests: XCTestCase {

    var sut: CharListInteractor!

    var presenterSpy: CharListPresenterSpy!
    var charactersServiceSpy: CharactersServiceSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        presenterSpy = CharListPresenterSpy()
        charactersServiceSpy = CharactersServiceSpy()

        sut = CharListInteractor()
        sut.presenter = presenterSpy
        let apiManager = ApiManager.sharedInstance
        apiManager.charactersService = charactersServiceSpy
        sut.apiManager = apiManager
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInteractorgetCharactersCallsgetCharactersFromServiceWithError() {
        // Given
        charactersServiceSpy.setSuccess(false)
        sut.apiManager?.charactersService = charactersServiceSpy

        // When
        sut.getCharacters()

        // Then
        XCTAssert(charactersServiceSpy.getCharactersCalled, "Must call to getCharacters of charactersService")
        XCTAssertFalse(presenterSpy.presentCharactersCalled, "Must NOT call to present to presentCharacters")
        XCTAssertFalse(presenterSpy.presentMoreCharactersCalled, "Must NOT call to present to presentMoreCharacters")
        XCTAssertFalse(presenterSpy.presentMoreCharactersCalled, "Must NOT call to present to presentMoreCharacters")
        XCTAssert(presenterSpy.presentErrorCalled, "Must call to presenter to presentError")
    }

    func testInteractorCallsPresentCharactersWhenNoPagination() {
        // Given
        charactersServiceSpy.setSuccess(true)
        sut.apiManager?.charactersService = charactersServiceSpy

        // When
        sut.getCharacters()

        // Then
        XCTAssert(charactersServiceSpy.getCharactersCalled, "Must call to getCharacters of charactersService")
        XCTAssert(presenterSpy.presentCharactersCalled, "Must call to presenter to  presentCharacters")
    }

    func testInteractorCallsPresentMoreCharactersWhenPagination() {
        // Given
        charactersServiceSpy.setSuccess(true)
        sut.apiManager?.charactersService = charactersServiceSpy

        // When
        sut.getMoreCharacters()

        // Then
        XCTAssert(charactersServiceSpy.getCharactersCalled, "Must call to getCharacters of charactersService")
        XCTAssert(presenterSpy.presentMoreCharactersCalled, "Must call to presenter to presentMoreCharacters")

    }

    // MARK: - Spy Classes
    class CharListPresenterSpy: CharListPresenterOutputProtocol {
        var interactor: CharListInteractorInputProtocol?
        var router: CharListRouterProtocol?
        var view: CharListViewControllerProtocol?

        var viewLoadedCalled = false
        var viewEndOfTableReachedCalled = false
        var presentCharactersCalled = false
        var presentMoreCharactersCalled = false
        var navigateToDetailCalled = false
        var presentErrorCalled = false
        var presentMessageCalled = false

        func viewLoaded() {
            viewLoadedCalled = true
        }

        func viewEndOfTableReached() {
            viewEndOfTableReachedCalled = true
        }

        func presentCharacters(_ characters: [Character]) {
            presentCharactersCalled = true
        }

        func presentMoreCharacters(_ characters: [Character]) {
            presentMoreCharactersCalled = true
        }

        func navigateToDetail(indexPath: IndexPath) {
            navigateToDetailCalled = true
        }

        func presentError(_ error: Error) {
            presentErrorCalled = true
        }

        func presentMessage(_ message: String, title: String) {
            presentMessageCalled = true
        }
    }

    class CharactersServiceSpy: CharactersServiceProtocol {
        var fakeData: Bool = false
        var jsonName: String = ""
        var jsonFake: [String: String] = [ : ]
        var networkError: NetworkError = .networkFailure
        var fakeResponse: FakeServiceResponse = .json

        var success: Bool
        var characters: [Character] = []

        var getCharactersCalled = false

        func getCharacters(nameStartsWith: String?, limit: Int?, page: Int, completion: @escaping (Result<[String: Any]?, NetworkError>) -> Void) {
            getCharactersCalled = true
            if success {
                let bundle = Bundle(for: type(of: self))
                let characters = Utils.readJSONFromFile(name: "Loki", bundle: bundle)
                return completion(.success(characters))
            } else {
                return completion(.failure(.networkFailure))
            }
        }
        
        init() {
            self.success = true
            self.characters = []
        }
        
        func setSuccess(_ success: Bool) {
            self.success = success
        }
    }
}
