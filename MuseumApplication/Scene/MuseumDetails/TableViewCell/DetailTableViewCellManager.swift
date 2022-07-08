//
//  DetailTableViewCellManager.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import Foundation

enum DetailTitleType: String, Equatable {
    case title = "Title:"
    case dimension = "Dimensions:"
    case artistDisplayName = "Artist Name:"
    case artistDate = "Artist Date:"
    case objectDate = "Object Date:"
    case accessionYear = "Accession Year:"
    case department = "Department:"
    case country = "Country:"
    case culture = "Culture:"
    case repository = "Repository:"
}

protocol DetailsTableViewCellInputs: AnyObject {
    var outputs: DetailsTableViewCellOutputs? { get set }
    func cellLoaded()
}

protocol DetailsTableViewCellOutputs: AnyObject {
    func cellData(title: String, data: String)
}

final class DetailsTableViewCellManager {
    
    weak var outputs: DetailsTableViewCellOutputs?
    
    private var title: DetailTitleType
    private var cellData: String
    init(title: DetailTitleType, data: String){
        self.title = title
        self.cellData = data
    }
}

extension DetailsTableViewCellManager: DetailsTableViewCellInputs {
   
    func cellLoaded() {
        self.outputs?.cellData(title: self.title.rawValue , data: cellData)
    }
}
