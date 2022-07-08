//
//  SearchMuseumManager.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation

//MARK: Inputs
protocol SearchMuseumInputs: AnyObject{
    var outputs: SearchMuseumOutputs? { get set }
    func searchButtonTapped(_ query: String?)
    func viewLoaded()
    func numberOfCellinSection(for index: Int)-> Int
    func getCellData(for index: Int)-> String
    func getTitleText()->String
    func textFieldChanged(by text: String)
}

//MARK: Outputs
protocol SearchMuseumOutputs: AnyObject {
    func reloadView()
}

//MARK: ManagerProtocol
protocol SearchManagable: AnyObject{
    var errorString: String { get }
    var emptyDataSet: String { get }
    var dataSource: [String] { set get }
    var invalidQueryError: String { get }
    func createDataSource(searchResult: [Int])
}

final class SearchMuseumManager {
    
    weak var outputs: SearchMuseumOutputs?
    var errorString: String { "This key is not present. Please search again with valid key" }
    var emptyDataSet: String { "Please write something in above given field and press Search button." }
    var invalidQueryError: String { "The object id should be greater than 3." }
    
    private let service: MuseumService
    var dataSource: [String] = []
    
    init(service: MuseumService) {
        self.service = service
    }
    
    deinit {
        print("deinitialzed")
    }
}

extension SearchMuseumManager: SearchManagable {
    
    func createDataSource(searchResult: [Int]) {
        dataSource = searchResult.isEmpty ? [errorString] : searchResult.map {"\($0)"}
        self.outputs?.reloadView()
    }
}

extension SearchMuseumManager: SearchMuseumInputs {
    
    func viewLoaded() {
        dataSource = [emptyDataSet]
        self.outputs?.reloadView()
    }
    
    func getTitleText() -> String {
        return "Search.."
    }
    
    func numberOfCellinSection(for index: Int) -> Int {
        return self.dataSource.count
    }
    
    func getCellData(for index: Int) -> String {
        return self.dataSource[index]
    }
    
    func searchButtonTapped(_ query: String?) {
        guard let query = query else {
            return
        }
        if query.count < 3 {
            self.dataSource = [invalidQueryError]
            self.outputs?.reloadView()
            return
        }
        self.service.searchMuseums(query: query) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let finalResult):
                self.createDataSource(searchResult: finalResult.objectIDs ?? [])
            case .failure(let err):
                self.dataSource = [err.localizedDescription]
                self.outputs?.reloadView()
            }
        }
    }
    
    func textFieldChanged(by text: String) {
        if text.count < 3 {
            self.dataSource = [emptyDataSet]
            self.outputs?.reloadView()
        }
    }
}
