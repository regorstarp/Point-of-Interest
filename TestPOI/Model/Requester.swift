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
                        if let id = subJson["id"].string, let title = subJson["title"].string, let geocoordinates = subJson["geocoordinates"].string {
                            let point: PointOfInterest = PointOfInterest(id: id, title: title, geocoordinates: geocoordinates)
                            pointList.append(point)
                        } else {
                            self.result = false
                        }
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
                
                if let id = json["id"].string, let title = json["title"].string, let geocoordinates = json["geocoordinates"].string, let address = json["address"].string, let transport = json["transport"].string, let email = json["email"].string, let description = json["description"].string, let phone = json["phone"].string {
                    point = PointOfInterest(id: id, title: title, geocoordinates: geocoordinates, address: address, transport: transport, email: email, description: description, phone: phone)
                    print(point.description)
                } else {
                    self.result = false
                }
                
            case .failure(_):
                self.result = false
            }
            completion(self.result, point)
        }
        
    }
    
}
