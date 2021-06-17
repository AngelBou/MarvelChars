//
//  CharDetailPresenter.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation
import UIKit

protocol CharDetailPresenterProtocol: class {
    var interactor: CharDetailInteractorProtocol? { get set }
    var router: CharDetailRouterProtocol? { get set }
    var view: CharDetailViewControllerProtocol? { get set }

    // Presenter methods
    func presentPhoto(_ photo: UIImage)

    // Events
    func viewLoaded()
}

class CharDetailPresenter: CharDetailPresenterProtocol {

    var interactor: CharDetailInteractorProtocol?
    var router: CharDetailRouterProtocol?
    weak var view: CharDetailViewControllerProtocol?

    private var character: Character?

    func viewLoaded() {
        displayName()
        displayDescription()
        loadCharacterPhoto()
    }
    
    init(character: Character) {
        self.character = character
    }

    // MARK: - Presenter Methods
    func presentPhoto(_ photo: UIImage) {
        self.view?.displayImage(photo)
    }

    // MARK: - Events
    private func displayName() {
        view?.displayName(character?.name ?? "")
    }

    private func displayDescription() {
        let name = character?.name ?? Texts.CharDetail.DescriptionPart1
        let noDescriptionText = "\(name) " + Texts.CharDetail.DescriptionPart2

        if let description = character?.description, !description.isEmpty {
            view?.displayDescription(description)
        } else {
            view?.displayDescription(noDescriptionText)
        }
    }

    private func loadCharacterPhoto() {
        guard let character = character else { return }
        
        // Show placeholder imagen
        showPlaceholderImage()
        
        // Get character photo
        interactor?.getPhoto(for: character)
    }
    
    private func showPlaceholderImage() {
        let bundle = Bundle(for: type(of: self))
        guard let placeholder = UIImage(named: "placeholder", in: bundle, with: nil) else { return }
        self.view?.displayImage(placeholder)
    }
}
