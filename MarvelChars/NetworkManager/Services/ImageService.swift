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

class ImageService: ImageServiceProtocol {

    func getImage(_ character: Character,
                  completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
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
