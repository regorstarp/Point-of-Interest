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
        interactor.requestPointOfInterest({ [weak self] (item: PointOfInterest) in
            self?.viewModel.id.value = item.id
            self?.viewModel.title.value = item.title
            self?.viewModel.description.value = item.description
            self?.viewModel.geocoordinates.value = item.geocoordinates
            self?.viewModel.email.value = item.email
            self?.viewModel.phone.value = item.phone
            self?.viewModel.address.value = item.address
            self?.viewModel.transport.value = item.transport
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
