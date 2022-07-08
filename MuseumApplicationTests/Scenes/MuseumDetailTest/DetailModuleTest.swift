//
//  DetailModuleTest.swift
//  MuseumApplicationTests
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import XCTest
@testable import MuseumApplication

class DetailModuleTest: XCTestCase {
    
    var sut: MuseumDetailsManager!
    var apiService:ApiServiceMocked!

    override func setUpWithError() throws {
        apiService = ApiServiceMocked()
        sut = MuseumDetailsManager(clickedItem: "", apiService: apiService)
    }
    
    func test_CheckDataSource(){
        var response: MuseumDetailsModel?
        apiService.fetchMeuseumDetails(query: "MuseumDetailsResponseMocked") { result in
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.title, "Tommaso di Folco Portinari (1428–1501); Maria Portinari (Maria Maddalena Baroncelli, born 1456)")
        guard let response = response else {
            return
        }
        sut.createDataSource(response)
        XCTAssertTrue(sut.dataSource.count > 0)
        XCTAssertEqual(sut.getNumberOfCell(for: 0), sut.dataSource.count)
        XCTAssertEqual(sut.dataSource.count, 10)
        XCTAssertEqual(sut.getCellData(for: 0).0, sut.dataSource.first?.0)
        XCTAssertEqual(sut.getCellData(for: 0).1, sut.dataSource.first?.1)
        XCTAssertEqual(sut.getCellData(for: 0).0, .title)
        XCTAssertEqual(sut.getCellData(for: 0).1, "Tommaso di Folco Portinari (1428–1501); Maria Portinari (Maria Maddalena Baroncelli, born 1456)")
    }
    
    func test_TitleText(){
        XCTAssertNotNil(sut.getTitleText())
        XCTAssertEqual(sut.getTitleText(), "Details..")
    }
}
