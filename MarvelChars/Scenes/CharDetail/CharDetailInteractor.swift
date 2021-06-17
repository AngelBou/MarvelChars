//
//  CharDetailInteractor.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation
import UIKit

protocol CharDetailInteractorInputProtocol {
    func getPhoto(for character: Character)
}

protocol CharDetailInteractorOutputProtocol {
    var presenter: CharDetailPresenterOutputProtocol? { get set }
    var imageService: ImageServiceProtocol? {get set}
}

class CharDetailInteractor: CharDetailInteractorInputProtocol, CharDetailInteractorOutputProtocol {

    weak var presenter: CharDetailPresenterOutputProtocol?

    var imageService: ImageServiceProtocol?

    func getPhoto(for character: Character) {
        
        var photo: UIImage?

        imageService?.getImage(character) { (result) in
            switch result {
            case .success(let image):
                photo = image
            case .failure:
                photo = UIImage(systemName: "not_available", withConfiguration: nil)
            }

            guard let photo = photo else { return }

            self.presenter?.presentPhoto(photo)
        }
    }
}
