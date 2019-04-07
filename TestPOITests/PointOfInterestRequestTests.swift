//
//  PointOfInterestRequestTests.swift
//  TestPOITests
//
//  Created by Roger Prats on 06/04/2019.
//  Copyright © 2019 Design4. All rights reserved.
//

import XCTest
@testable import TestPOI

class PointOfInterestRequestTests: XCTestCase {
    let request = PointOfInterestRequest()

    func testMakingURLRequest() throws {
        let urlRequest = try request.makeRequest(from: "1")
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "t21services.herokuapp.com")
        XCTAssertEqual(urlRequest.url?.path, "/points/1")
    }
    
    func testParsingResponse() throws {
        
        let jsonData = "{\"id\":\"1\",\"title\":\"Casa Batlló\",\"geocoordinates\":\"41.391926,2.165208\",\"address\":\"Paseo de Gracia, 43, 08007 Barcelona\",\"transport\":\"Underground:Passeig de Gràcia -L3\",\"email\":\"http://www.casabatllo.es/en/\",\"description\":\"Casa Batlló is a key feature in the architecture of modernist Barcelona.\",\"phone\":\"info@casabatllo.cat\"}".data(using: .utf8)!
        let response = try request.parseResponse(data: jsonData)
        
        let pointDetail = PointDetail(id: "1", title: "Casa Batlló", geocoordinates: "41.391926,2.165208", address: "Paseo de Gracia, 43, 08007 Barcelona", transport: "Underground:Passeig de Gràcia -L3", email: "http://www.casabatllo.es/en/", description: "Casa Batlló is a key feature in the architecture of modernist Barcelona.", phone: "info@casabatllo.cat")
        XCTAssertEqual(response, pointDetail)
    }
}
