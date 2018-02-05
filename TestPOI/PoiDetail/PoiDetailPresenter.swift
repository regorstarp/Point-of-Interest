//
//  PoiDetailPresenter.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol PoiDetailEventHandler: class
{
    var viewModel: PoiDetailViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
}

// MARK: - Protocol to be defined at Presenter
protocol PoiDetailResponseHandler: class
{
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses
class PoiDetailPresenter: PoiDetailEventHandler, PoiDetailResponseHandler {
    
    //MARK: Relationships
    weak var viewController: PoiDetailViewUpdatesHandler?
    var interactor: PoiDetailRequestHandler!
    var wireframe: PoiDetailNavigationHandler!

    var viewModel = PoiDetailViewModel()
    
    //MARK: - EventHandler Protocol
    func handleViewWillAppear() {
        print("handleViewWillAppear")
        interactor.requestPointOfInterest({ [weak self] (item: PointOfInterest) in
            self?.viewModel.id = item.id
            self?.viewModel.title = item.title
            self?.viewModel.description = item.description
            self?.viewModel.geocoordinates = item.geocoordinates
            self?.viewModel.email = item.email
            self?.viewModel.phone = item.phone
            self?.viewModel.address = item.address
            self?.viewModel.transport = item.transport
        })
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    //MARK: - ResponseHandler Protocol
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}

}
