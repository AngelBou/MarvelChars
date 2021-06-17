//
//  Json.swift
//  MarvelCharsTests
//
//  Created by Angel Boullon on 18/06/2021.
//

import Foundation

class Json {
    static func readJSONFromFile(name: String, bundle: Bundle) -> [String: Any] {
        var result: [String: Any] = [:]
        
        if let path = bundle.path(forResource: name, ofType: "json") {
            
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let options = JSONSerialization.ReadingOptions(rawValue: 0)
                if let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: options) as?  [String: Any] {
                    result = jsonResult
                }
            }
        }
        return result
    }
}
