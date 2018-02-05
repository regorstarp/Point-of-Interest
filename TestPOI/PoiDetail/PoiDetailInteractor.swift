//
//  PoiDetailInteractor.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol PoiDetailRequestHandler: class
{
    func requestPointOfInterest( _ completion: @escaping ( _ entity: PointOfInterest) -> Void)
    // func requestSomething()
    // func requestUser(id:String)
}

// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class PoiDetailInteractor: PoiDetailRequestHandler
{
    //MARK: Relationships
    weak var presenter: PoiDetailResponseHandler?
    
    let poiId: String
    
    init ( _ poiId: String) {
        self.poiId = poiId
    }
    //MARK: - RequestHandler Protocol
    //func requestSomething(){}
    private var requester = Requester()
    //MARK: Interactor Interface
    
    func requestPointOfInterest( _ completion: @escaping ( _ entity: PointOfInterest) -> Void) {
        //Dispatch es per concurrencia?
        self.requester.requestPointOfInterest(id: self.poiId) { (result: Bool, point: PointOfInterest) in
            if result {
                completion(point)
            } else {
                //
            }
        }
    }
}
