//
//  PointsOfInterestRequest.swift
//  TestPOITests
//
//  Created by Roger Prats on 06/04/2019.
//  Copyright © 2019 Design4. All rights reserved.
//

import XCTest
@testable import TestPOI

class PointsOfInterestRequestTests: XCTestCase {
    let request = PointsOfInterestRequest()
    
    func testParsingResponse() throws {
        
        let jsonData = "{\"list\": [{\"id\":\"1\",\"title\":\"Casa Batlló\",\"geocoordinates\":\"41.391926,2.165208\"},{\"id\":\"2\",\"title\":\"Fundació Antoni Tàpies\",\"geocoordinates\":\"41.39154,2.163835\"}]}".data(using: .utf8)!
        let response = try request.parseResponse(data: jsonData)
        
        let pointsOfInterest = [
            PointOfInterest(id: "1", title: "Casa Batlló", geocoordinates: "41.391926,2.165208"),
            PointOfInterest(id: "2", title: "Fundació Antoni Tàpies", geocoordinates: "41.39154,2.163835")
        ]
        
        XCTAssertEqual(response, pointsOfInterest)
    }
}

