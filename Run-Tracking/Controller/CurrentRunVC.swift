//
//  CurrentRunVC.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class CurrentRunVC: LocationVC {

    @IBOutlet weak var swipeBGImage: UIImageView!
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var firstLocation: CLLocation!
    var lastLocation: CLLocation!
    var timer = Timer()
    var coordinateLocations = List<Location>()
    var runDistance: Double = 0.0   // for distance
    var counter: Int = 0    // for duration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImage.addGestureRecognizer(swipeGesture)
        sliderImage.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    // let manager works in every time view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.delegate = self
        locationManager?.distanceFilter = 10   // min distance by meter
        startRun()
    }
    
    func startRun() {
        locationManager?.startUpdatingLocation()
        startTimer()
         pauseBtn.setImage(UIImage(named: "pauseButton"), for: .normal)
    }
    
    func endRun() {
        locationManager?.stopUpdatingLocation()
        // add to Realm
        Run.addRunToRealm(distance: runDistance, duration: counter, locations: coordinateLocations)
    }
    
    func startTimer() {
        durationLbl.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        counter += 1
        durationLbl.text = counter.formatTimeDurationToString()
    }

    @IBAction func pauseBtn(_ sender: UIButton) {
        if timer.isValid {
        pauseRun()
        }else {
            startRun()
        }
    }
    func pauseRun() {
        firstLocation = nil
        lastLocation = nil
        timer.invalidate()
        locationManager?.stopUpdatingLocation()
        pauseBtn.setImage(UIImage(named: "resumeButton"), for: .normal)
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        // make the slider image moves on x
        let minAdjust: CGFloat = 73
        let maxAdjust: CGFloat = 122
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImage.center.x - minAdjust) && sliderView.center.x <= (swipeBGImage.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                }else if sliderView.center.x >= swipeBGImage.center.x + maxAdjust {
                    sliderView.center.x = swipeBGImage.center.x + maxAdjust
                    // End run codes
                    endRun()
                    dismiss(animated: true, completion: nil)
                }else {
                    sliderView.center.x = swipeBGImage.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBGImage.center.x - minAdjust
                }
            }
        }
    }



}


extension CurrentRunVC: CLLocationManagerDelegate {
    // when allow authorization we center the map
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstLocation == nil {
            firstLocation = locations.first
        }else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            runDistance = round(1000*runDistance)/1000
            let newLocation = Location(latitude: Double(lastLocation.coordinate.latitude), longitude: Double(firstLocation.coordinate.longitude))
            coordinateLocations.insert(newLocation, at: 0)
            distanceLbl.text = "\(runDistance)"
        }
        lastLocation = locations.last
    }
}
