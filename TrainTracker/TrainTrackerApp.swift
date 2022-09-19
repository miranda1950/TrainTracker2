//
//  TrainTrackerApp.swift
//  TrainTracker
//
//  Created by COBE on 13.09.2022..
//

import SwiftUI
import Firebase

 class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct TrainTrackerApp: App {
    
    @StateObject private var dataController = DataController()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
       
        WindowGroup {
            
          //  FirstHome()
            
          //  MainView()
            
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
