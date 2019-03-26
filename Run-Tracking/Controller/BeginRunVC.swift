//
//  FirstViewController.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        
    }

    // let manager works in every time view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.delegate = self
        mapView.delegate = self
        locationManager?.startUpdatingLocation()
        setupMapView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager?.stopUpdatingLocation()
    }
    
    @IBAction func locationCenterBtn(_ sender: UIButton) {
        centerMap()
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        lastRunView.isHidden = true
        if mapView.overlays.count > 0 {
            mapView.removeOverlays(mapView.overlays)
        }
    }
    
    func centerMap() {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    func addLastRunToMap() -> MKPolyline? {
        // get the last run from Realm Run model
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
            distanceLbl.text = "Distance: \(lastRun.distance) m"
            durationLbl.text = "Duration: \(lastRun.duration.formatTimeDurationToString())"
            // As MKPolyline works with coordinates
            var coordinates = [CLLocationCoordinate2D]()
            for location in lastRun.locations {
                coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                
            }
        return MKPolyline(coordinates: coordinates, count: lastRun.locations.count)
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            lastRunView.isHidden = false
        }else {
            lastRunView.isHidden = true
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}

