//
//  PoiListInteractor.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol PoiListRequestHandler: class
{
    // func requestSomething()
    // func requestUser(id:String)
    
    func requestItems()
    func filterItems(_ searchText: String, _ model: PoiListViewModel)
}

class PoiListInteractor: PoiListRequestHandler
{
    //MARK: VIPER relationships
    weak var presenter: PoiListResponseHandler?
    
    //MARK: Private vars
    
    private var isRequestingItems = false
    private var requester = Requester()
    //MARK: Interactor Interface
    
    func requestItems() {
        //todo: modify the example code
        DispatchQueue.main.async {
            if !self.isRequestingItems {
                self.isRequestingItems = true
                self.presenter?.itemsRequestDidStart()
                DispatchQueue.main.async {
                    self.requester.requestPointsOfInterest { (result: Bool, list: [PointOfInterest]) in
                        if result {
                            self.isRequestingItems = false
                            self.presenter?.itemsRequestDidFinish(list)
                        }
                    }
                }
            }
        }
    }
    //guardar llista poi a interactor
    func filterItems(_ searchText: String, _ model: PoiListViewModel) {
        var filteredPoi = [PoiListCellViewModel]()
        filteredPoi = model.items.filter({( point : PoiListCellViewModel) -> Bool in
            return point.title.lowercased().contains(searchText.lowercased())
        })
        print("interactor -> count filteredPoi: \(filteredPoi.count)")
        self.presenter?.itemsFilteringDidFinish(filteredPoi)
    }
    
    //MARK: Interactor Private
    
    
}
