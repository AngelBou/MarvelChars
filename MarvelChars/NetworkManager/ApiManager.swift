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

struct Root: Decodable {
    let marvelServerURL: String
}

final class ApiManager {

    static let sharedInstance = ApiManager()
    
    static var baseURL: String = defaultBaseUrl()
    
    private let session = URLSession(configuration: .default)

    static func defaultBaseUrl() -> String {
        var baseUrl = ""
        if let config = Bundle.main.object(forInfoDictionaryKey: "ServerConfigFile") as? String {
            if let url = Bundle.main.url(forResource: config, withExtension: "plist") {
                if let data = try? Data(contentsOf: url), let result = try? PropertyListDecoder().decode(Root.self, from: data) {
                    baseUrl = result.marvelServerURL
                }
            }
        }
        return baseUrl
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
