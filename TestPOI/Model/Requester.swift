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
                        //string! puede dar error
                        let point: PointOfInterest = PointOfInterest(id: subJson["id"].string!, title: subJson["title"].string!, geocoordinates: subJson["geocoordinates"].string!)
                        pointList.append(point)
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
                let json = JSON(value)
                point = PointOfInterest(id: json["id"].string!, title: json["title"].string!, geocoordinates: json["geocoordinates"].string!, address: json["address"].string!, transport: json["transport"].string!, email: json["email"].string!, description: json["description"].string!, phone: json["phone"].string!)
                
            case .failure(_):
                self.result = false
            }
            completion(self.result, point)
        }
        
    }
    
}
