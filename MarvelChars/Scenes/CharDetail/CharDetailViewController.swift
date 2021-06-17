//
//  CharDetailViewController.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

protocol CharDetailViewControllerProtocol: class {
    var presenter: CharDetailPresenterInputProtocol? { get set }
    
    // Display
    func displayImage(_ image: UIImage)
    func displayName(_ text: String)
    func displayDescription(_ text: String)
}

class CharDetailViewController: UIViewController, CharDetailViewControllerProtocol {

    // MARK: - Properties
    var presenter: CharDetailPresenterInputProtocol?

    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var descripLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewLoaded()
    }

    // MARK: - Setup
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white

        setupNavigationBar()
        setupViews()
        setupConstrainsts()
        setupAccessibility()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setupViews() {
        self.view.addSubview(characterImageView)
        self.view.addSubview(descripLabel)
    }

    func setupConstrainsts() {
        let widthHeightConstant = self.view.frame.width * 0.8
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.widthAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40)
            .isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true

        descripLabel.translatesAutoresizingMaskIntoConstraints = false
        descripLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            .isActive = true
        descripLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20)
            .isActive = true
        descripLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
    }

    func setupAccessibility() {
        view.accessibilityLabel = "Detail screen"
        characterImageView.accessibilityLabel = "Photo"
        descripLabel.accessibilityLabel = "Description"
    }

    // MARK: - Display
    func displayImage(_ image: UIImage) {
        characterImageView.image = image
    }

    func displayName(_ text: String) {
        self.navigationItem.title = text
        self.navigationItem.isAccessibilityElement = true
        self.navigationItem.accessibilityLabel = "Title"
    }

    func displayDescription(_ text: String) {
        descripLabel.text = text
    }
}
