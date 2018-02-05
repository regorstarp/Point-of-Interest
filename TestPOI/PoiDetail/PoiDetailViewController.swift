//
//  PoiDetailViewController.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit
import MapKit

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
    
    let regionRadius: CLLocationDistance = 1000
    let newPin = MKPointAnnotation()
    
    //MARK: - IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var mailContentLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneContentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressContentLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var transportContentLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }
    
    func configureBindings() {
        print("configure bindings")
        print("description \(viewModel.description)")
        //Add the ViewModel bindings here ...
        descriptionLabel.text = "Description"
        descriptionTextView.text = viewModel.description
        mailLabel.text = "Mail"
        mailContentLabel.text = viewModel.email
        phoneLabel.text = "Phone"
        phoneContentLabel.text = viewModel.phone
        addressLabel.text = "Address"
        addressContentLabel.text = viewModel.address
        transportLabel.text = "Transport"
        transportContentLabel.text = viewModel.transport
        
//        // map set up
//        let coordinatesArray = viewModel.geocoordinates.components(separatedBy: ",")
//        let latitude = (coordinatesArray[0] as NSString).doubleValue
//        let longitude = (coordinatesArray[1] as NSString).doubleValue
//        // set initial location
//        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
//        centerMapOnLocation(location: initialLocation)
//        newPin.coordinate = initialLocation.coordinate
//        mapView.addAnnotation(newPin)
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
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    
}
