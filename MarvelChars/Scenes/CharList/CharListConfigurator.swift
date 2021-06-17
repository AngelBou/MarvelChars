//
//  CharListConfigurator.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

class CharListConfigurator {

    static func createScene() -> UIViewController {

        let interactor = CharListInteractor()
        interactor.charactersService = CharactersService()

        let presenter = CharListPresenter()
        presenter.router = CharListRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let viewController = CharListViewController()
        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }
}
