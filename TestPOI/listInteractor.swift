//
//  listInteractor.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol listRequestHandler: class
{
    // func requestSomething()
    // func requestUser(id:String)
    
    func requestItems()
}

class listInteractor: listRequestHandler
{
    //MARK: VIPER relationships
    weak var presenter: listResponseHandler?
    
    //MARK: Private vars
    
    private var isRequestingItems = false
    
    //MARK: Interactor Interface
    
    func requestItems() {
        //todo: modify the example code
        DispatchQueue.main.async {
            if !self.isRequestingItems {
                self.isRequestingItems = true
                self.presenter?.itemsRequestDidStart()
                DispatchQueue.main.async {
                    let result = ["Entity 1","Entity 2","Entity 3","Entity 4","Entity 5"]
                    self.isRequestingItems = false
                    self.presenter?.itemsRequestDidFinish(result)
                }
            }
        }
    }
    
    //MARK: Interactor Private
    
    
}
