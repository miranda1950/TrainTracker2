//
//  FirstHome.swift
//  TrainTracker
//
//  Created by COBE on 15.09.2022..
//

import SwiftUI

struct FirstHome: View {
    
    @State private var isUserCurrentlyLoggedOut: Bool = false
    
    var body: some View {
        NavigationView {
            if self.isUserCurrentlyLoggedOut {
                MainView()
            } else {
                ContentView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
            }
        }
        
    }
}

struct FirstHome_Previews: PreviewProvider {
    static var previews: some View {
        FirstHome()
    }
}
