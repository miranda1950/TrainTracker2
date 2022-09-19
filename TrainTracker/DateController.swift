//
//  DateController.swift
//  TrainTracker
//
//  Created by COBE on 18.09.2022..
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ReservationDetails")
    
    
    init() {
        container.loadPersistentStores{
            description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
