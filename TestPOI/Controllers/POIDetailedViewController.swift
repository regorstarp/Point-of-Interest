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


    var selectedPOI: PointOfInterest?
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
        
        if let point = selectedPOI {
            title = point.title
            
            descriptionTextView.isEditable = false
            descriptionTextView.isScrollEnabled = false
            
            descriptionLabel.text = "Description"
            mailLabel.text = "Mail"
            phoneLabel.text = "Phone"
            addressLabel.text = "Address"
            transportLabel.text = "Transport"
            descriptionTextView.text = point.description
            mailContentLabel.text = point.email
            phoneContentLabel.text = point.phone
            addressContentLabel.text = point.address
            transportContentLabel.text = point.transport
            
            
            // map set up
            let coordinatesArray = point.geocoordinates.components(separatedBy: ",")
            let latitude = (coordinatesArray[0] as NSString).doubleValue
            let longitude = (coordinatesArray[1] as NSString).doubleValue
            // set initial location
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location: initialLocation)
            newPin.coordinate = initialLocation.coordinate
            mapView.addAnnotation(newPin)

        } else {
            
            let alert = UIAlertController(title: "Couldn't load the selected point", message: "", preferredStyle: .alert)
            
            let acceptAction = UIAlertAction(title: "Go Back", style: .default) { (_) -> Void in
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(acceptAction)
            self.present(alert, animated: true)
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
