//
//  File.swift
//  TestPOI
//
//  Created by Design4 on 23/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation

class Requester {
    
    let url = "https://t21services.herokuapp.com/points"
    
    func fetchPointsOfInterestJSON(completion: @escaping (Result<[Point], Error>) -> ()) {
        let urlString = "https://t21services.herokuapp.com/points"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //success
            do {
                let root = try JSONDecoder().decode(Root.self, from: data!)
                completion(.success(root.list))
        
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func requestPointOfInterest(for pointId: String, completion: @escaping (Result<PointDetail, Error>) -> () ) {
        let urlString = "https://t21services.herokuapp.com/points" + "/\(pointId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //success
            do {
                let pointDetail = try JSONDecoder().decode(PointDetail.self, from: data!)
                completion(.success(pointDetail))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
    }
}
