//
//  SearchMuseumResponse.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation

// MARK: - Welcome
struct SearchMuseumResponse: Decodable {
    let total: Int
    let objectIDs: [Int]?
}
