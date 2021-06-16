//
//  CharListPresenter.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation
import UIKit

protocol CharListPresenterProtocol: class {
    var interactor: CharListInteractorProtocol? { get set }
    var router: CharListRouterProtocol? { get set }
    var view: CharListViewControllerProtocol? { get set }

    // View Events
    func viewLoaded()
    func viewEndOfTableReached()

    // Presentation
    func presentCharacters(_ characters: [Character])
    func presentMoreCharacters(_ characters: [Character])
    // Messages
    func presentError(_ error: Error)
    func presentMessage(_ message: String, title: String)
    
    // Navigation
    func navigateToDetail(indexPath: IndexPath)
}

class CharListPresenter: CharListPresenterProtocol {

    var interactor: CharListInteractorProtocol?
    var router: CharListRouterProtocol?
    weak var view: CharListViewControllerProtocol?

    var characters: [Character] = []

    // MARK: - Events
    func viewLoaded() {
        interactor?.getCharacters()
    }
    
    func viewEndOfTableReached() {
        interactor?.getMoreCharacters()
    }

    // MARK: - Presentation
    func presentCharacters(_ characters: [Character]) {
        self.characters = characters
        view?.displayCharacters(characters)
    }

    func presentMoreCharacters(_ characters: [Character]) {
        self.characters.append(contentsOf: characters)
        view?.displayCharacters(self.characters)
    }

    func presentError(_ error: Error) {
        view?.displayError(error)
    }

    func presentMessage(_ message: String, title: String) {
        view?.displayMessage(message, title: title)
    }

    // MARK: - Navigation
    func navigateToDetail(indexPath: IndexPath) {
        guard let character = characters[safe: indexPath.row] else { return }
        router?.navigateToDetailScene(on: view, character: character)
    }
}
