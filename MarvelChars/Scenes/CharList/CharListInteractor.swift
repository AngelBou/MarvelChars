//
//  CharListInteractor.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation

protocol CharListInteractorProtocol {
    var presenter: CharListPresenterProtocol? { get set }
    var apiManager: ApiManager? {get set}

    func getCharacters()
    func getMoreCharacters()
}

class CharListInteractor: CharListInteractorProtocol {

    weak var presenter: CharListPresenterProtocol?
    var apiManager: ApiManager?

    private var page: Int = 0

    func getCharacters() {
        getCharacters(searchString: nil, pagination: false)
    }

    func getMoreCharacters() {
        getCharacters(searchString: nil, pagination: true)
    }

    func getCharacters(searchString: String?, pagination: Bool = false) {

        if pagination {
            self.page += 1
        }
        
        apiManager?.charactersService?.getCharacters(nameStartsWith: searchString,
                                                     limit: 100,
                                                     page: page) { (result) in
            switch result {
            case .success(let json):
                
                var characterList: [Character] = []
                
                if let data: [String: Any] = json, let dataDict: [String: Any] = data[JsonField.data] as? [String: Any] {
                    if let resultsArray: [[String: Any]] = dataDict[JsonField.results] as? [[String: Any]] {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: resultsArray, options: .prettyPrinted)
                            characterList = try JSONDecoder().decode([Character].self, from: jsonData)
                        } catch  let error {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                if pagination {
                    self.presenter?.presentMoreCharacters(characterList)
                } else {
                    self.presenter?.presentCharacters(characterList)
                }
            case .failure(let error):
                self.presenter?.presentError(error)
            }
        }
    }
}
