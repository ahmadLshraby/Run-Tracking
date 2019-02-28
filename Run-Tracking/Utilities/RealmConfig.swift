//
//  RealmConfig.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/28/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    
    static var runDataConfig: Realm.Configuration {
        // create path in the device to save
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Realm Run Log")
        let config = Realm.Configuration(
        fileURL: realmPath,
        schemaVersion: 0,
        migrationBlock: { Migration, oldSchemaVersion in
            if ( oldSchemaVersion < 0) {
                // nothing to do
                // Realm will auto detect new properties and remove properties
            }
        })
        return config
    }
}
