//
//  CharDetailInteractor.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation
import UIKit

protocol CharDetailInteractorProtocol {
    var presenter: CharDetailPresenterProtocol? { get set }
    var apiManager: ApiManager? {get set}

    func getPhoto(for character: Character)
}

class CharDetailInteractor: CharDetailInteractorProtocol {

    weak var presenter: CharDetailPresenterProtocol?

    var apiManager: ApiManager?

    func getPhoto(for character: Character) {
        
        var photo: UIImage?

        apiManager?.imageService?.getImage(character) { (result) in
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
