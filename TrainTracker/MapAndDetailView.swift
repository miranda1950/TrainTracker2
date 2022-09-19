//
//  MapAndDetailView.swift
//  TrainTracker
//
//  Created by COBE on 18.09.2022..
//

import CoreLocation
import SwiftUI
import MapKit

struct MapAndDetailView: View {
    
    let reservation: Reservation
    @StateObject private var mapAPI = MapAPI()
    @State private var text = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Enter the address", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Button("Add location") {
                mapAPI.getLocation(address: text, delta: 0.5)
            }
            
            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) {
                location in
                
                MapMarker(coordinate: location.coordinate, tint: .blue)
                
            }
            .ignoresSafeArea()
        }
        
    }
}

struct MapAndDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapAndDetailView(reservation: Reservation())
    }
}
