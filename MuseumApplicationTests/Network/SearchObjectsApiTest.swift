//
//  SearchObjectsApiTest.swift
//  MuseumApplicationTests
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import XCTest
@testable import MuseumApplication

class SearchObjectsApiTest: XCTestCase {

    func testJsonParsingForSearchAPI() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "SearchApiMockResponse", ofType: "json") else {
            fatalError("File not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert to json")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decodedResult = try? JSONDecoder().decode(SearchMuseumResponse.self, from: jsonData)
        XCTAssertNotNil(jsonData)
        XCTAssertNotNil(decodedResult)
        XCTAssertEqual(decodedResult?.total, 3)
        XCTAssertEqual(decodedResult?.objectIDs?[1],201128)
        XCTAssertEqual(decodedResult?.objectIDs?.count, decodedResult?.total)
    }
}
