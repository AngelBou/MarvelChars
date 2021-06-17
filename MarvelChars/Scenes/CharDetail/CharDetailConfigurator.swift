//
//  CharDetailConfigurator.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

class CharDetailConfigurator {

    static func createScene(character: Character) -> UIViewController {

        let interactor = CharDetailInteractor()
        interactor.apiManager = ApiManager.sharedInstance

        let presenter = CharDetailPresenter(character: character)
        presenter.router = CharDetailRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let viewController = CharDetailViewController()
        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }

}
