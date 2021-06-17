//
//  CharDetailViewControllerTests.swift
//  MarvelCharsTests
//
//  Created by Angel Boullon on 16/06/2021.
//

import XCTest
@testable import MarvelChars

class CharDetailViewControllerTests: XCTestCase {

    var sut: CharDetailViewController!
    var presenterSpy: CharDetailPresenterSpy!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        presenterSpy = CharDetailPresenterSpy()
        
        sut = CharDetailViewController()
        presenterSpy.view = sut
        sut.presenter = presenterSpy
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllerCallsPresenterToViewLoadedWhenViewDidLoad() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(presenterSpy.viewLoadedCalled, "Must call to present to viewLoaded")
    }
    
    func testCharacterShowsCorrectly() {
        // Given
        let name = "Thanos"
        let description = "Thanos description"
        
        let thumbnail = Thumbnail(path: "",
                                  ext: "")
        let char = Character(id: 3,
                             name: name,
                             description: description,
                             thumbnail: thumbnail)
        
        // Connect a presenter class with fake interactor
        let presenter = CharDetailPresenter(character: char)
        presenter.view = sut
        let interactor = CharDetailInteractorSpy()
        interactor.presenter = presenter
        presenter.interactor = interactor
        sut.presenter = presenter
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.navigationItem.title, char.name, "Character name must be shown correcty")
        XCTAssertEqual(sut.descripLabel.text, char.description, "Character description must be shown correcty")
    }
}

    // MARK: - Spy Classes
    class CharDetailPresenterSpy: CharDetailPresenterInputProtocol {
        var interactor: CharDetailInteractorInputProtocol?
        
        var router: CharDetailRouterProtocol?
        var view: CharDetailViewControllerProtocol?
        var character: Character?
        
        var presentPhotoCalled: Bool = false
        var viewLoadedCalled: Bool = false
        
        func presentPhoto(_ photo: UIImage) {
            presentPhotoCalled = true
        }
        
        func viewLoaded() {
            viewLoadedCalled = true
        }
    }
    
    class CharDetailInteractorSpy: CharDetailInteractorInputProtocol {
        var presenter: CharDetailPresenterOutputProtocol?
        
        var apiManager: ApiManager?
        
        func getPhoto(for character: Character) {
            let bundle = Bundle(for: type(of: self))
            if let image = UIImage(named: "placeholder", in: bundle, with: nil) {
                presenter?.presentPhoto(image)
            }
        }
    }
