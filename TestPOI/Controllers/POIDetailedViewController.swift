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
    
    let pointMapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let point = selectedPOI {
            title = point.title
            descriptionTextView.text = point.description
            mailContentLabel.text = point.email
            phoneContentLabel.text = point.phone
            addressContentLabel.text = point.address
            transportContentLabel.text = point.transport
            
            view.addSubview(descriptionLabel)
            view.addSubview(descriptionTextView)
            view.addSubview(mailLabel)
            view.addSubview(mailContentLabel)
            view.addSubview(phoneLabel)
            view.addSubview(phoneContentLabel)
            view.addSubview(addressLabel)
            view.addSubview(addressContentLabel)
            view.addSubview(transportLabel)
            view.addSubview(transportContentLabel)
            
            // map set up
            let coordinatesArray = point.geocoordinates.components(separatedBy: ",")
            let latitude = (coordinatesArray[0] as NSString).doubleValue
            let longitude = (coordinatesArray[1] as NSString).doubleValue
            // set initial location
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location: initialLocation)
            newPin.coordinate = initialLocation.coordinate
            pointMapView.addAnnotation(newPin)

            view.addSubview(pointMapView)
            setUpLayout()

        } else {
            
            let alert = UIAlertController(title: "Couldn't load the selected point", message: "", preferredStyle: .alert)
            
            let acceptAction = UIAlertAction(title: "Go Back", style: .default) { (_) -> Void in
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(acceptAction)
            self.present(alert, animated: true)
        }
    }
    
    
    func setUpLayout() {
        
        descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        let caracteristics = [mailLabel, mailContentLabel, phoneLabel, phoneContentLabel, addressLabel, addressContentLabel, transportLabel, transportContentLabel]
        
        var previous: UILabel!
        
        for label in caracteristics {
            
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            label.adjustsFontSizeToFitWidth = true
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
            
            if previous != nil {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor).isActive = true
            }
            
            previous = label
        }
        
        pointMapView.topAnchor.constraint(equalTo: transportContentLabel.bottomAnchor, constant: 25).isActive = true
        pointMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pointMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pointMapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        pointMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        pointMapView.setRegion(coordinateRegion, animated: true)
    }

}
