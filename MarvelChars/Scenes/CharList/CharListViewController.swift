//
//  CharListViewController.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import UIKit

protocol CharListViewControllerProtocol: class {
    var presenter: CharListPresenterInputProtocol? { get set }

    func refresh()
    func displayCharacters(_ characters: [Character])

    func displayError(_ error: Error)
    func displayMessage(_ message: String, title: String)
}

class CharListViewController: UIViewController, CharListViewControllerProtocol {

    // MARK: - Properties
    var presenter: CharListPresenterInputProtocol?
    let table = UITableView()
    var characters: [Character]? = []

    // MARK: - Lifecycle Methods
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    // MARK: - Setup
    func setupUI() {
        self.view.backgroundColor = .white

        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupAccessibility()
    }

    func setupNavigationBar() {
        self.navigationItem.title = Texts.CharList.ScreenTitle
        self.navigationItem.isAccessibilityElement = true
        self.navigationItem.accessibilityLabel = "Title"
        self.navigationItem.backBarButtonItem?.isAccessibilityElement = true
        self.navigationItem.backBarButtonItem?.accessibilityLabel = "Back"

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setupViews() {
        table.delegate = self
        table.dataSource = self

        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    func setupAccessibility() {
        view.accessibilityLabel = "MARVEL characters list screen"
        table.accessibilityLabel = "Marvel characters list"
    }

    // MARK: - Actions
    func refresh() {
        table.reloadData()
    }

    func displayCharacters(_ characters: [Character]) {
        self.view.isHidden = false
        self.characters = characters
        refresh()

    }

    // MARK: - Messages
    func displayError(_ error: Error) {
        let alert = UIAlertController(title: Texts.Common.Button.Error, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Texts.Common.Button.Ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func displayMessage(_ message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Texts.Common.Button.Ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Delegate and DataSource for Table
extension CharListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetail(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let count = self.characters?.count else { return }
        if indexPath.row == count - 15 {
            self.presenter?.viewEndOfTableReached()
        }
    }
}

extension CharListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters?[indexPath.row].name ?? ""
        cell.textLabel?.numberOfLines = 0

        cell.accessibilityLabel = "Cell_\(indexPath.row)"
        let accessibilityName = characters?[indexPath.row].name ?? String(indexPath.row)
        cell.textLabel?.accessibilityLabel = "name_\(accessibilityName)"

        return cell
    }
}
