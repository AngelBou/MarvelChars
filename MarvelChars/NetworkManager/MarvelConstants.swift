//
//  Endpoints.swift
//  MarvelChars
//
//  Created by Angel Boullon on 15/06/2021.
//

/// Marvel API
struct MarvelAPI {
    static let publicKey = "a97e89847d934d0d551f6252cb4be16f"
    static let privateKey = "978985e55e35edf030a37de670b4ea650cf2e580"
}

/// Service endoints
struct Endpoint {
    static let characters = "/v1/public/characters"
    static let comics = "/v1/public/comics"
}

struct JsonField {
    static let data = "data"
    static let results = "results"
}
