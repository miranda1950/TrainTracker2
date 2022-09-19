//
//  MyTravellings.swift
//  TrainTracker
//
//  Created by COBE on 16.09.2022..
//

import SwiftUI

struct MyTravellings: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var reservations: FetchedResults<Reservation>
    
    @State private var showingMapSheet = false
    
    
    
    var body: some View {
        NavigationView {
        List {
            ForEach(reservations) { reservation in
                NavigationLink {
                    MapAndDetailView(reservation: reservation)
                }label: {
                    HStack {
                        Text(reservation.destination?.prefix(2).uppercased() ?? "un").bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .mask(Circle())
                        Spacer()
                        
                        
                        VStack {
                            Text("Datum: \(reservation.dateOfAparture!, style: .date)")
                            Text("From: \(reservation.startingPoint ?? "Unknown")")
                            Text("To: \(reservation.destination ?? "Unknown")")
                        }
                        
                    }
                    
                }
            
        }
            .onDelete(perform: deleteBooks)
        }
        .navigationBarBackButtonHidden(true)
        
    }
    }
        
    func deleteBooks(at offsets: IndexSet) {
            
            for offset in offsets {
                let reservation = reservations[offset]
                moc.delete(reservation)
                
            }
            
            try? moc.save()
        }
    
    
}

struct MyTravellings_Previews: PreviewProvider {
    static var previews: some View {
        MyTravellings()
    }
}
