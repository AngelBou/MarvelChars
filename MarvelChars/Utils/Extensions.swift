//
//  Extensions.swift
//  MarvelChars
//
//  Created by Angel Boullon on 13/06/2021.
//

import Foundation

extension Collection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
