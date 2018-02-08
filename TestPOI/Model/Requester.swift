//
//  File.swift
//  TestPOI
//
//  Created by Design4 on 23/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Requester {
    
    let url = "https://t21services.herokuapp.com/points"
    var result: Bool = false
    
    func requestPointsOfInterest( completion: @escaping (Bool, [PointOfInterest]) -> ()) -> Void {
        var pointList = [PointOfInterest]()
        Alamofire.request(url).responseJSON { response in
            switch response.result {
                case .success(let value):
                    self.result = true
                    let json = JSON(value)
                    for (_, subJson) in json["list"] {
                        pointList.append(PointOfInterest(json: subJson))
                    }
                
                case .failure(_):
                    self.result = false
                }
            completion(self.result, pointList)
        }
        
    }
    
    func requestPointOfInterest(id: String, completion: @escaping (Bool, PointOfInterest) -> ()) -> Void {
        
        Alamofire.request(url + "/\(id)").responseJSON { response in
            var point: PointOfInterest = PointOfInterest(id: "", title: "", geocoordinates: "")
            switch response.result {
            case .success(let value):
                self.result = true
                let jsonRecieved = JSON(value)
                point = PointOfInterest(json: jsonRecieved)
                
            case .failure(_):
                self.result = false
            }
            completion(self.result, point)
        }
        
    }
    
    func requestApi(url: URL) {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                print(response.result.value ?? "empty")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
