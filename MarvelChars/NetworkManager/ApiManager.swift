//
//  ApiManager.swift
//  MarvelChars
//
//  Created by Angel Boullon on 15/06/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidSession
    case networkFailure
    case invalidParameter
    case invalidRequest
    case transportError(Error)
    case serverSideError(Int)
    case invalidResponse
    case unknownError
}

struct ApiRequest {
    let urlString: String
    let parameters: [String: String]
    let method: HTTPMethod
}

enum HTTPMethod {
    case get
    case post
}

enum Services {
    case charactersService
    case imageService
}

enum FakeServiceResponse {
    case json
    case jsonData
    case image
    case failure
}

protocol ServiceProtocol {
    var fakeData: Bool { get set }

    associatedtype FakeResponseType
    func fakeDataResponse() -> (Result<FakeResponseType, NetworkError>)
}

final class ApiManager {

    static let sharedInstance = ApiManager()
    
    var charactersService: CharactersServiceProtocol?
    var imageService: ImageServiceProtocol?
    static var baseURL: String = defaultBaseUrl()
    
    private let session = URLSession(configuration: .default)

    static func defaultBaseUrl() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "MARVELServerUrl") as? String ?? ""
    }
    
    // MARK: - setters
    func setFakeData(fakeData: Bool) {
        charactersService = CharactersService(fakeData: fakeData)
        imageService = ImageService(fakeData: fakeData)
    }
    
    // MARK: - Requests
    func send(request: ApiRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {

        guard var urlComponents = URLComponents(string: request.urlString) else {
            completion(.failure(.invalidParameter))
            return
        }

        urlComponents.queryItems = request.parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    
        guard let url = urlComponents.url else {
            completion(.failure(.invalidParameter))
            return
        }

        let dataTask = session.dataTask(with: URLRequest(url: url)) { data, response, error in

            DispatchQueue.main.async {
                if let error = self.networkErrorFrom(response, error) {
                    completion(.failure(error))
                } else {
                    completion(Result.success(data))
                }
            }
        }
        dataTask.resume()
    }

    func fetchImage(url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        //let session = URLSession.shared
        let url = URL(string: url)

        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            DispatchQueue.main.async {
                if let error = self.networkErrorFrom(response, error) {
                    completion(.failure(error))
                } else {
                    completion(Result.success(data))
                }
            }
        }
        dataTask.resume()
    }
    
    func networkErrorFrom(_ response: URLResponse?, _ error: Error?) -> NetworkError? {
        if let error = error {
            return .transportError(error)
        }
        
        if let response = response as? HTTPURLResponse {
            let status = response.statusCode
            switch status {
            case 200...299:
                // Response Ok
                return nil
            case 499:
                return .invalidSession
            default:
                return .serverSideError(status)
            }
        } else {
            // Ok
            return nil
        }
        
    }
}
