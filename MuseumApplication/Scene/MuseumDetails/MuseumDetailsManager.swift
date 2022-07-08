//
//  MuseumDetailsManager.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import Foundation

protocol MuseumDetailsInputs: AnyObject{
    var delegate: MuseumDetailsOutputs? { get set }
    func viewLoaded()
    func getTitleText()->String
    func getCellData(for index: Int)->(DetailTitleType,String)
    func getNumberOfCell(for section: Int)-> Int
}

//MARK: Outputs
protocol MuseumDetailsOutputs: AnyObject {
    func reloadView(with image: String)
    func showError(with message: String)
}

//MARK: ManagerProtocol
protocol MuseumDetailsManagable: AnyObject{
    var dataSource: [(DetailTitleType,String)] { get set }
    func fetchDetails()
    func createDataSource(_ result: MuseumDetailsModel)
}


final class MuseumDetailsManager {
    
    private var clickedItem: String
    private let apiService: MuseumService
    weak var delegate: MuseumDetailsOutputs?
    
    var dataSource: [(DetailTitleType,String)] = []
    
    init(clickedItem: String, apiService: MuseumService) {
        self.clickedItem = clickedItem
        self.apiService = apiService
    }
}

extension MuseumDetailsManager: MuseumDetailsInputs {
    func getTitleText() -> String {
        return "Details.."
    }
    
    func getCellData(for index: Int)->(DetailTitleType,String) {
        dataSource[index]
    }
    
    func getNumberOfCell(for section: Int)-> Int {
        return self.dataSource.count
    }
    
    func viewLoaded() {
        fetchDetails()
    }
}

extension MuseumDetailsManager: MuseumDetailsManagable {
    
    func fetchDetails() {
        self.apiService.fetchMeuseumDetails(query: clickedItem) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.createDataSource(response)
            case .failure(let error):
                self.delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
    func createDataSource(_ result: MuseumDetailsModel) {
        
        dataSource.append((.title, result.title?.isEmpty ?? true  ? "N/A" : result.title ?? "N/A"))
        dataSource.append((.dimension, result.dimensions?.isEmpty ?? true ? "N/A" : result.dimensions ?? "NA" ))
        dataSource.append((.artistDisplayName, result.artistDisplayName?.isEmpty ?? true ? "N/A" : result.artistDisplayName ?? "N/A"))
        dataSource.append((.artistDate, (result.artistBeginDate?.isEmpty ?? true || result.artistEndDate?.isEmpty ?? true) ? "N/A" : "\(result.artistBeginDate ?? "N/A") - \(result.artistEndDate ?? "N/A")" ))
        dataSource.append((.objectDate, result.objectDate?.isEmpty ?? true ? "N/A" : result.objectDate ?? "N/A"))
        dataSource.append((.accessionYear, result.accessionYear?.isEmpty ?? true ? "N/A" : result.accessionYear ?? "N/A"))
        dataSource.append((.department, result.department?.isEmpty ?? true ? "N/A" : result.department ?? "N/A"))
        dataSource.append((.country, result.country?.isEmpty ?? true ? "N/A" : result.country ?? "N/A" ))
        dataSource.append((.culture, result.culture?.isEmpty ?? true ? "N/A" : result.culture ?? "N/A"))
        dataSource.append((.repository, result.repository?.isEmpty ?? true ? "N/A" : result.repository ?? "NA"))
        
        self.delegate?.reloadView(with: result.primaryImageSmall ?? "")
    }
}
