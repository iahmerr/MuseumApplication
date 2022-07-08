//
//  SearchRequestModel.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation

// MARK: - MuseumDetailsModel
struct MuseumDetailsModel: Decodable {
    var objectID: Int?
    var accessionYear: String?
    var primaryImage: String?
    var primaryImageSmall: String?
    var additionalImages: [String]?
    var department: String?
    var objectName: String?
    var title: String?
    var culture: String?
    var artistDisplayName: String?
    var artistDisplayBio: String?
    var artistNationality: String?
    var artistBeginDate: String?
    var artistEndDate: String?
    var objectDate: String?
    var objectBeginDate: Int?
    var objectEndDate: Int?
    var medium: String?
    var dimensions: String?
    var country: String?
    var region: String?
    var repository: String?
}
