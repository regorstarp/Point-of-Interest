//
//  APILoaderTest.swift
//  TestPOITests
//
//  Created by Roger Prats on 06/04/2019.
//  Copyright © 2019 Design4. All rights reserved.
//

import XCTest
@testable import TestPOI

class APILoaderTest: XCTestCase {
    
    var loader: APIRequestLoader<PointOfInterestRequest>!

    override func setUp() {
        let request = PointOfInterestRequest()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }
    
    func testLoaderSuccess() {
        let pointId = "1"
        let mockJSONData = "{\"id\":\"1\",\"title\":\"Casa Batlló\",\"geocoordinates\":\"41.391926,2.165208\",\"address\":\"Paseo de Gracia, 43, 08007 Barcelona\",\"transport\":\"Underground:Passeig de Gràcia -L3\",\"email\":\"http://www.casabatllo.es/en/\",\"description\":\"Casa Batlló is a key feature in the architecture of modernist Barcelona.\",\"phone\":\"info@casabatllo.cat\"}".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.path.contains("/points/1"), true)
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        let pointDetail = PointDetail(id: "1", title: "Casa Batlló", geocoordinates: "41.391926,2.165208", address: "Paseo de Gracia, 43, 08007 Barcelona", transport: "Underground:Passeig de Gràcia -L3", email: "http://www.casabatllo.es/en/", description: "Casa Batlló is a key feature in the architecture of modernist Barcelona.", phone: "info@casabatllo.cat")
        
        loader.loadAPIRequest(requestData: pointId) { pointOfInterest, error in
            XCTAssertEqual(pointOfInterest, pointDetail)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

}

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // ...
    }
}
