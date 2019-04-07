//
//  File.swift
//  TestPOI
//
//  Created by Design4 on 23/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation

class Requester {
    
    func fetchPointsOfInterestJSON(completion: @escaping (Result<[PointOfInterest], Error>) -> ()) {
        let request = PointsOfInterestRequest()
        
        let url = URL(string: "https://t21services.herokuapp.com/points")!
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            guard let data = data else { return completion(.failure(error!)) }
            
            do {
                let parsedResponse = try request.parseResponse(data: data)
                completion(.success(parsedResponse))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func requestPointOfInterest(for pointId: String, completion: @escaping (Result<PointDetail, Error>) -> () ) {
        let request = PointOfInterestRequest()
        
        do {
            let url = try request.makeRequest(from: pointId)
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                
                guard let data = data else { return completion(.failure(error!)) }
                
                do {
                    let parsedResponse = try request.parseResponse(data: data)
                    completion(.success(parsedResponse))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }.resume()
        } catch let urlError { completion(.failure(urlError)) }
    }
}

struct PointOfInterestRequest: APIRequest {
    func makeRequest(from pointId: String) throws -> URLRequest {
        let urlString = "https://t21services.herokuapp.com/points" + "/\(pointId)"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> PointDetail {
        return try JSONDecoder().decode(PointDetail.self, from: data)
    }
}

struct PointsOfInterestRequest {
    
    func parseResponse(data: Data) throws -> [PointOfInterest] {
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.list
    }
}


