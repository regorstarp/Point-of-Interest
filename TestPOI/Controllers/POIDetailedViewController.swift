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

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    
    
    var selectedPOI: PointOfInterest?
    let regionRadius: CLLocationDistance = 1000
    let newPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let point = selectedPOI {
            title = point.title
            descriptionTextView.text = point.description
            mailLabel.text = point.email
            phoneLabel.text = point.phone
            addressLabel.text = point.address
            transportLabel.text = point.transport
            
            //map set up
            let coordinatesArray = point.geocoordinates.components(separatedBy: ",")
            let latitude = (coordinatesArray[0] as NSString).doubleValue
            let longitude = (coordinatesArray[1] as NSString).doubleValue
            // set initial location
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location: initialLocation)
            newPin.coordinate = initialLocation.coordinate
            mapView.addAnnotation(newPin)
            
        } else {
            print("error loading poi")
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
