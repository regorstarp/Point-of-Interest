//
//  POIDetailedViewController.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import UIKit
import MapKit

class POIDetailViewController: UIViewController {


    var selectedPOI: PointDetail?
    let regionRadius: CLLocationDistance = 1000
    let newPin = MKPointAnnotation()
    
    //IBOutlets
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = selectedPOI?.title
        
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        
        setupInformation()
        setupMapView()
    }
    
    private func setupInformation() {
        descriptionLabel.text = "Description"
        mailLabel.text = "Mail"
        phoneLabel.text = "Phone"
        addressLabel.text = "Address"
        transportLabel.text = "Transport"
        descriptionTextView.text = selectedPOI?.description
        mailContentLabel.text = selectedPOI?.email
        phoneContentLabel.text = selectedPOI?.phone
        addressContentLabel.text = selectedPOI?.address
        transportContentLabel.text = selectedPOI?.transport
    }
    
    private func setupMapView() {
        // map set up
        guard let coordinatesArray = selectedPOI?.geocoordinates.components(separatedBy: ",") else { return }
        let latitude = (coordinatesArray[0] as NSString).doubleValue
        let longitude = (coordinatesArray[1] as NSString).doubleValue
        // set initial location
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: initialLocation)
        newPin.coordinate = initialLocation.coordinate
        mapView.addAnnotation(newPin)
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
