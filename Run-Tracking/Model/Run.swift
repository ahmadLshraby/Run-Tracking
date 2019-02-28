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
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["duration", "date"]
    }
    
    convenience init(distance: Double, duration: Int) {
        self.init()
        self.distance = distance
        self.duration = duration
        self.date = NSDate()
        self.id = UUID().uuidString
    }
    
    static func addRunToRealm(distance: Double, duration: Int) {
        let run = Run(distance: distance, duration: duration)   // instance instaitiated from the model and takes the inputs from the func
        do {
            let realm = try Realm()
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
            let realm = try Realm()
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)   // to get the last run first
            return runs
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    

}
