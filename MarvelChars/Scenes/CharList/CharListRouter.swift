//
//  CharListRouter.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

protocol CharListRouterProtocol {
    func navigateToDetailScene(on view: CharListViewControllerProtocol?, character: Character)
}

class CharListRouter: CharListRouterProtocol {

    func navigateToDetailScene(on view: CharListViewControllerProtocol?, character: Character) {

        guard let viewController = view as? UIViewController else { return }

        guard let detailViewController = CharDetailConfigurator.createScene() as? CharDetailViewController else { return }
        detailViewController.presenter?.character = character
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
