//
//  ObjectDetailAPITest.swift
//  MuseumApplicationTests
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import XCTest
@testable import MuseumApplication

class ObjectDetailAPITest: XCTestCase {
    
    func testJsonParsingForDetailAPI() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "ObjectDetailResponseMocked", ofType: "json") else {
            fatalError("File not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert to json")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decodedResult = try? JSONDecoder().decode(MuseumDetailsModel.self, from: jsonData)
        XCTAssertNotNil(jsonData)
        XCTAssertNotNil(decodedResult)
        XCTAssertEqual(decodedResult?.objectID, 437056)
        XCTAssertEqual(decodedResult?.title, "Tommaso di Folco Portinari (1428–1501); Maria Portinari (Maria Maddalena Baroncelli, born 1456)")
    }
}
