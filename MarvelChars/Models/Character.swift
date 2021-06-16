//
//  Character.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

// swiftlint:disable identifier_name

struct Character: Codable, Equatable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    var comics: Comics?
    var series: Series?
    var stories: Stories?
    var events: Events?
    var urls: [Url]?
    
    init(id: Int? = nil,
         name: String? = nil,
         description: String? = nil,
         modified: String? = nil,
         thumbnail: Thumbnail? = nil,
         resourceURI: String? = nil,
         comics: Comics? = nil,
         series: Series? = nil,
         stories: Stories? = nil,
         events: Events? = nil,
         urls: [Url]? = nil) {
        
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}
