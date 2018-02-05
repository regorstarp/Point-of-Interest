//
//  PoiDetailViewController.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at ViewController
protocol PoiDetailViewUpdatesHandler: class
{
    //That part should be implemented with RxSwift.
    //func updateSomeView()
}

// MARK: - ViewController Class must implement ViewModelHandler Protocol to handle ViewModel from Presenter
class PoiDetailViewController: UIViewController, PoiDetailViewUpdatesHandler
{
    //MARK: Relationships
    var presenter: PoiDetailEventHandler!
    
    var viewModel: PoiDetailViewModel {
        return presenter.viewModel
    }
    
    //MARK: - IBOutlets
    
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }
    
    func configureBindings() {
        //Add the ViewModel bindings here ...
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappear()
    }
    
    //MARK: - UI Configuration
    
    private func configureOutlets() {
        
    }
    
    //MARK: - PoiDetailViewUpdatesHandler
    
    
    
    //MARK: - Private methods
    
    
    
}
