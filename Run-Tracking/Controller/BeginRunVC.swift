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
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        print("runs: \(Run.getAllRuns())")
    }

    // let manager works in every time view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager?.stopUpdatingLocation()
    }
    
    @IBAction func locationCenterBtn(_ sender: UIButton) {
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        lastRunView.isHidden = true
    }
    
    func getLastRun() {
        if let lastRun = Run.getAllRuns()?.first {
            distanceLbl.text = "Distance: \(lastRun.distance)"
            durationLbl.text = "Duration: \(lastRun.duration.formatTimeDurationToString())"
        }else {
            lastRunView.isHidden = true
            return
            
        }
        
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

