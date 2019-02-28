//
//  Location.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/28/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    // define lat, lon as they are Double not like CLLocation that Realm not support
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
