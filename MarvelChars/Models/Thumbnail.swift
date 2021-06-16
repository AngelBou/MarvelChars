//
//  Thumbnail.swift
//  MarvelChars
//
//  Created by Angel Boullon on 11/06/2021.
//

struct Thumbnail: Codable, Equatable {
    var path: String?
    var ext: String?

    var url: String {
        guard let thumbPath = self.path, let thumbExt = self.ext else {
           return ""
        }
        return thumbPath + "." + thumbExt
    }

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
