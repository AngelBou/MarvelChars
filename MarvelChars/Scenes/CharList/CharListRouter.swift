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

        if let detailViewController = CharDetailConfigurator.createScene(character: character) as? CharDetailViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
