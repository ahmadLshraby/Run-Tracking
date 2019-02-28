//
//  Run.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/28/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    // declare all the properties we want to save in Realm database
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var duration: Int = 0
    @objc dynamic var date = NSDate()
    @objc dynamic var id: String = ""
    // add Location model in a list (array in Realm) to keep tracking every location coordinates when running
    // every single Run or every id has a List<Location>
   public private(set) var locations = List<Location>()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["duration", "date"]
    }
    
    convenience init(distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.distance = distance
        self.duration = duration
        self.date = NSDate()
        self.id = UUID().uuidString
        self.locations = locations
    }
    
    static func addRunToRealm(distance: Double, duration: Int, locations: List<Location>) {
        let run = Run(distance: distance, duration: duration, locations: locations)   // instance instaitiated from the model and takes the inputs from the func
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)   // instead of Realm() which is default configuration
            try realm.write {
                realm.add(run)
                print("run saved")
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)   // instead of Realm() which is default configuration
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)   // to get the last run by date be in the first 
            return runs
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    

}
