//
//  SearchResultTableViewCellManager.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import Foundation

protocol SearchResultManagerOutput: AnyObject{
    func postResult(result: String)
}

protocol SearchResultManagerInputs: AnyObject{
    var delegate: SearchResultManagerOutput? { get set }
    func cellLoaded()
}

final class SearchResultTableViewCellManager {
    
    weak var delegate: SearchResultManagerOutput?
    private var result: String
    init(result: String){
        self.result = result
    }
}

extension SearchResultTableViewCellManager: SearchResultManagerInputs{
    func cellLoaded() {
        self.delegate?.postResult(result: self.result)
    }
}

