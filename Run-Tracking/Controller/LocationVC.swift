//
//  LocationVC.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import MapKit

// make LocationVC to any location proccess and all classes needs location can inherite from it
class LocationVC: UIViewController, MKMapViewDelegate {

    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()     // instance
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest    // get the accuracy
        locationManager?.activityType = .fitness    // choose activity depending on the app needings
    }

    // check the location authorization status , if not authorized then the manager request it from the user
    func checkLocationAuthStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    


    
    

    
    
    
    
}
