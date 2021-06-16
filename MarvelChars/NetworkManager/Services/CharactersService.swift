//
//  CharactersService.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

import Foundation

protocol CharactersServiceProtocol {
    func getCharacters(nameStartsWith: String?, limit: Int?, page: Int, completion: @escaping (Result<[String: Any]?, NetworkError>) -> Void)
    
    var fakeData: Bool { get set }
    var jsonName: String { get set }
    var jsonFake: [String: String] { get set }
    var networkError: NetworkError { get set }
    var fakeResponse: FakeServiceResponse { get set }
}

class CharactersService: CharactersServiceProtocol, ServiceProtocol {

    var fakeData: Bool = false
    var jsonName: String = "Loki" // Default json response
    var jsonFake: [String: String] = [:]
    var networkError: NetworkError = .networkFailure // Default network error
    var fakeResponse: FakeServiceResponse = .json

    let defaultLimit = 100   // Default limit for characters endpoint call. valid value between 1..100

    init(fakeData: Bool) {
        self.fakeData = fakeData
    }

    func fakeDataResponse() -> (Result<[String: Any]?, NetworkError>) {
        switch fakeResponse {
        case .json:
            let bundle = Bundle(for: type(of: self))
            let json = readJSONFromFile(name: jsonName, bundle: bundle)
            return .success(json)
        case .jsonData:
            return .success(jsonFake)
        default:
            return .failure(networkError)
        }
    }

    func getCharacters(nameStartsWith: String?,
                       limit: Int?,
                       page: Int,
                       completion: @escaping (Result<[String: Any]?, NetworkError>) -> Void) {

        // Return Fake data for testing purposes
        if fakeData {
            completion(fakeDataResponse())
            return
        }

        // Call to Api to obtain response
        let urlString = ApiManager.baseURL + Endpoint.characters
        
        // Parameters
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(timestamp + MarvelAPI.privateKey + MarvelAPI.publicKey).lowercased()

        let serviceLimit = limit ?? defaultLimit

        var urlParams = [
            "ts": timestamp,
            "hash": hash,
            "apikey": MarvelAPI.publicKey,
            "limit": String(serviceLimit),
            "offset": String(page * serviceLimit)
        ]

        if let name = nameStartsWith {
            urlParams.updateValue(name, forKey: "nameStartsWith")
        }

        let request = ApiRequest(urlString: urlString,
                                    parameters: urlParams,
                                    method: .get)

        ApiManager.sharedInstance.send(request: request) { (response) in
            switch response {
            case .success(let data):
                guard let dataResponse = data, let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []) else {
                    return completion(.success(nil))
                }

                if let data: [String: Any] = json as? [String: Any] {
                    completion(.success(data))
                } else {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
