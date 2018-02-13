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
import T21RxAdditions

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
    
    let pointMapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    let descriptionLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Description"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return uiLabel
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16.0)
        return textView
    }()
    
    let mailLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Mail"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return uiLabel
    }()
    
    let mailContentLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    let phoneLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Phone"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return uiLabel
    }()
    
    let phoneContentLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    let addressLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Address"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return uiLabel
    }()
    
    let addressContentLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    let transportLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Transport"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return uiLabel
    }()
    
    let transportContentLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    var segmentedControl = UISegmentedControl()
    var contenedorInfo:UIView=UIView()
    var contenedorMapa:UIView=UIView()
    let regionRadius: CLLocationDistance = 500
    let newPin = MKPointAnnotation()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }
    
    func configureBindings() {
        //Add the ViewModel bindings here ...

        bindOnNext(viewModel.description) { [weak self] (description) -> Void in
            self?.descriptionTextView.text = description
        }
        bindOnNext(viewModel.email) { [weak self] (email) -> Void in
            self?.mailContentLabel.text = email
        }
        bindOnNext(viewModel.phone) { [weak self] (phone) -> Void in
            self?.phoneContentLabel.text = phone
        }
        bindOnNext(viewModel.address) { [weak self] (address) -> Void in
            self?.addressContentLabel.text = address
        }
        bindOnNext(viewModel.transport) { [weak self] (transport) -> Void in
            self?.transportContentLabel.text = transport
        }
        
        bindOnNext(viewModel.title) { [weak self] (title) -> Void in
            self?.title = title
        }
        
        bindOnNext(viewModel.geocoordinates) { [weak self] (geocoordinates) -> Void in
            if !geocoordinates.isEmpty {
                if let coordinatesArray = self?.viewModel.geocoordinates.value.components(separatedBy: ",") {
                    let latitude = (coordinatesArray[0] as NSString).doubleValue
                    let longitude = (coordinatesArray[1] as NSString).doubleValue
                    // set initial location
                    let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
                    self?.centerMapOnLocation(location: initialLocation)
                    self?.newPin.coordinate = initialLocation.coordinate
                    self?.pointMapView.addAnnotation((self?.newPin)!)
                }
            }
        }
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
        view.addSubview(segmentedControl)
        view.addSubview(contenedorInfo)
        view.addSubview(contenedorMapa)
        contenedorMapa.addSubview(pointMapView)
        contenedorInfo.addSubview(descriptionLabel)
        contenedorInfo.addSubview(descriptionTextView)
        let caracteristicsLabels = [mailLabel, mailContentLabel, phoneLabel, phoneContentLabel, addressLabel, addressContentLabel, transportLabel, transportContentLabel]
        
        caracteristicsLabels.forEach {
            contenedorInfo.addSubview($0)
        }
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contenedorMapa.translatesAutoresizingMaskIntoConstraints = false
        contenedorInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            contenedorInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contenedorInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contenedorInfo.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            contenedorInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contenedorMapa.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contenedorMapa.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contenedorMapa.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            contenedorMapa.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            pointMapView.leadingAnchor.constraint(equalTo: contenedorMapa.leadingAnchor),
            pointMapView.trailingAnchor.constraint(equalTo: contenedorMapa.trailingAnchor),
            pointMapView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15),
            pointMapView.bottomAnchor.constraint(equalTo: contenedorMapa.bottomAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contenedorInfo.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contenedorInfo.trailingAnchor, constant: -15),
            descriptionLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: contenedorInfo.leadingAnchor, constant: 15),
            descriptionTextView.trailingAnchor.constraint(equalTo: contenedorInfo.trailingAnchor, constant: -15)
            ])
        
        
        
        var previous: UILabel!
        
        for label in caracteristicsLabels {
            label.adjustsFontSizeToFitWidth = true
            label.leadingAnchor.constraint(equalTo: contenedorInfo.leadingAnchor, constant: 15).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            
            if previous != nil {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 15).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15).isActive = true
            }
            
            previous = label
            contenedorInfo.addSubview(label)
        }
        previous.bottomAnchor.constraint(equalTo: contenedorInfo.bottomAnchor, constant: -15)
        
        
        segmentedControl.insertSegment(withTitle: NSLocalizedString("info", comment: "comment"), at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: NSLocalizedString("mapa", comment: "comment"), at: 1, animated: false)
        segmentedControl.selectedSegmentIndex=0
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlAction(_:)), for: .valueChanged)
        
        contenedorMapa.isHidden = true
        
    }
    
    
    //MARK: - PoiDetailViewUpdatesHandler
    
    //MARK: - Private methods
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        pointMapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func segmentedControlAction(_ sender: AnyObject) {
        print("segmented control click")
        if(segmentedControl.selectedSegmentIndex == 0){
            contenedorInfo.isHidden=false
            contenedorMapa.isHidden=true
        }else{
            contenedorInfo.isHidden=true
            contenedorMapa.isHidden=false
        }
    }

    
    
}
