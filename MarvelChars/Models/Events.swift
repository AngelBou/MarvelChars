//
//  Events.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

struct Events: Codable, Equatable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventsItem]?
}
