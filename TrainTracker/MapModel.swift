//
//  MapModel.swift
//  TrainTracker
//
//  Created by COBE on 18.09.2022..
//

import Foundation
import MapKit

//managing api and structuring data model


struct Address: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let latitude, longitude: Double
    let name: String?
    
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapAPI: ObservableObject {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY =  "4feaef6afd7111a3e8a35032a97b9311"
    
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [Location] = []
    
    init() {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.55, longitude: 18.67), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        
        self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 45.55, longitude: 18.67)), at: 0)
    }
    
    //dohvaca lokacije
    func getLocation(address: String, delta: Double) {
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        
        //url for making request
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        guard let url = URL(string: url_string) else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }

            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
            if newCoordinates.data.isEmpty {
                print("Could not find the address")
                return
            }
            
            DispatchQueue.main.async {
                let details = newCoordinates.data[0]
                let lat = details.latitude
                let lon = details.longitude
                let name = details.name
                
                self.coordinates = [lat, lon]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                
                let new_location = Location(name: name ?? "Pin", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                
              //  self.locations.removeAll()
                self.locations.insert(new_location, at: 0)
                
                print("sucessfully loadeed the location")
            }
            
        }
        .resume()
    }
}
