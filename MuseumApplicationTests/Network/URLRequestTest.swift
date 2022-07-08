//
//  URLRequestTest.swift
//  MuseumApplicationTests
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import XCTest
@testable import MuseumApplication

class URLRequestTest: XCTestCase {

    var sut1: URLRequestConvertible?
    var sut2: URLRequestConvertible?
    
    override func setUp() {
        sut1 = Endpoint(route: .searchMuseum, method: .get, path: ["1234"])
        sut2 = Endpoint(route: .getMeuseumDetails, method: .get)
    }
    
    
    
    func test_SearchRequest(){
        guard let request = try? sut1?.urlRequest() else
        { return }
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://collectionapi.metmuseum.org/public/collection/v1/search/1234")
        XCTAssertNotNil(request)
    }
    
    func test_MuseumDetailsRequest() {
        
        guard let request = try? sut2?.urlRequest() else
         { return }
         XCTAssertEqual(request.httpMethod, "GET")
         XCTAssertEqual(request.url!.absoluteString, "https://collectionapi.metmuseum.org/public/collection/v1/objects")
        XCTAssertNotNil(request)
        
    }
}
