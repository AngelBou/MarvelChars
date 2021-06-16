//
//  CharListConfigurator.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

class CharListConfigurator {

    static func createScene() -> UIViewController {

        let viewController = CharListViewController()

        let presenter = CharListPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = CharListRouter()
        viewController.presenter?.view = viewController
        let interactor = CharListInteractor()
        interactor.apiManager = ApiManager.sharedInstance
        viewController.presenter?.interactor = interactor
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
}
