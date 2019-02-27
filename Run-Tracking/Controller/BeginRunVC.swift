//
//  FirstViewController.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }

    // let manager works in every time view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager?.stopUpdatingLocation()
    }
    
    @IBAction func locationCenterBtn(_ sender: UIButton) {
    }
    
    
    
    
}


extension BeginRunVC: CLLocationManagerDelegate {
        // when allow authorization we center the map
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                checkLocationAuthStatus()
                mapView.showsUserLocation = true
                mapView.userTrackingMode = .follow
            }
        }
}

