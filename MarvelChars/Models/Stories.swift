//
//  Stories.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

struct Stories: Codable, Equatable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StoriesItem]?
}
