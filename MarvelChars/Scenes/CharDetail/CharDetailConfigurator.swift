//
//  CharDetailConfigurator.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

class CharDetailConfigurator {

    static func createScene() -> UIViewController {

        let viewController = CharDetailViewController()

        let presenter = CharDetailPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = CharDetailRouter()
        viewController.presenter?.view = viewController
        let interactor = CharDetailInteractor()
        interactor.apiManager = ApiManager.sharedInstance
        viewController.presenter?.interactor = interactor
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }

}
