//
//  GetImageService.swift
//  MarvelChars
//
//  Created by Angel Boullon on 12/06/2021.
//
import UIKit

protocol ImageServiceProtocol {
    func getImage(_ character: Character,
                  completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

class ImageService: ImageServiceProtocol, ServiceProtocol {

    var fakeData: Bool = false
    let imageName: String = "thumbnail"

    var networkError: NetworkError = .networkFailure // Default network error
    var fakeResponse: FakeServiceResponse = .image

    init(fakeData: Bool) {
        self.fakeData = fakeData
    }

    func fakeDataResponse() -> (Result<UIImage, NetworkError>) {
        switch fakeResponse {
        case .image:
            let bundle = Bundle(for: type(of: self))
            if let image = UIImage(named: imageName, in: bundle, with: nil) {
                return .success(image)
            } else {
                return .failure(.invalidResponse)
            }
        default:
            return .failure(.invalidResponse)
        }
    }

    func getImage(_ character: Character,
                  completion: @escaping (Result<UIImage, NetworkError>) -> Void) {

        // Return Fake data for testing purposes
        if fakeData {
            completion(fakeDataResponse())
            return
        }
        
        guard let urlString = character.thumbnail?.url,
              let url = URL(string: urlString) else { return completion(.failure(.invalidParameter))}
        
        ApiManager.sharedInstance.fetchImage(url: url.absoluteString) { (response) in
            switch response {
            case .success(let data):
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
    }
}
