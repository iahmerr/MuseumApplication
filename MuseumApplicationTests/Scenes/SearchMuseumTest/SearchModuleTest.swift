//
//  SearchModuleTest.swift
//  MuseumApplicationTests
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import XCTest
@testable import MuseumApplication

class SearchModuleTest: XCTestCase {

    var sut: SearchMuseumManager!
    var apiService:ApiServiceMocked!
    
    override func setUpWithError() throws {
        apiService = ApiServiceMocked()
        sut = SearchMuseumManager(service: apiService)
    }
    
    func test_EmptyDataSet(){
        sut.viewLoaded()
        XCTAssertEqual(sut.numberOfCellinSection(for: 0), 1)
    }
    
    func test_ResponseDataSetSuccess(){
        var responseObjects:[Int] = []
        apiService.searchMuseums(query: "SearchApiMockResponse") { result in
            switch result {
            case .success(let response):
                responseObjects = response.objectIDs ?? []
            case .failure(let err):
                print("err", err.localizedDescription)
            }
        }
        XCTAssertFalse(responseObjects.isEmpty)
        XCTAssertEqual(responseObjects.count, 3)
        XCTAssertEqual(responseObjects.first, 234556)
        
        sut.createDataSource(searchResult: responseObjects)
        XCTAssertEqual(sut.dataSource.count, responseObjects.count)
        XCTAssertEqual(sut.numberOfCellinSection(for: 0), responseObjects.count)
    }
    
    func test_ResponseDataSetFailure(){
        apiService.isFailure = true
        var error: AppError?
        apiService.searchMuseums(query: "SearchApiMockResponse") { result in
            switch result {
            case .success(_):
                print("not happening")
            case .failure(let err):
                error = err
            }
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(AppError(error: "Error Occured"), error)
    }
    
    func test_ControllerTitle(){
        XCTAssertEqual(sut.getTitleText(), "Search..")
        XCTAssertNotNil(sut.getTitleText())
    }
    
    func test_changeInTextField(){
        self.sut.textFieldChanged(by: "12")
        XCTAssertEqual(self.sut.dataSource.count, 1)
        XCTAssertEqual(self.sut.dataSource.first, "Please write something in above given field and press Search button.")
    }
    
    func test_getCellData(){
        sut.dataSource = ["1","2","3"]
        XCTAssertEqual(sut.getCellData(for: 0), "1")
    }
    
    func test_ErrorTexts(){
        XCTAssertEqual(sut.errorString, "This key is not present. Please search again with valid key")
        XCTAssertNotNil(sut.emptyDataSet)
        
        XCTAssertEqual(sut.emptyDataSet, "Please write something in above given field and press Search button.")
        XCTAssertNotNil(sut.errorString)
        
        XCTAssertEqual(sut.invalidQueryError, "The object id should be greater than 3.")
        XCTAssertNotNil(sut.invalidQueryError)
    }
}
