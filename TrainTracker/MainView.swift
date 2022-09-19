//
//  MainView.swift
//  TrainTracker
//
//  Created by COBE on 15.09.2022..
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var index = 0
    @State private var startingPoint = ""
    @State private var destination = ""
    @State private var dateOfAparture = Date()
   @State private var numberOfSeatsLeft = Int.random(in: 1..<50)
    
      var hasSeats: Bool {
        if numberOfPeople > numberOfSeatsLeft {
            return false
        }
        return true
    }
    
  
    @State private var showingGraphsheet = false
    @State private var numberOfPeople = 0
    @State private var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                bedAdded = false
                foodAndDrinks = false
            }
        }
    }
    
    @State private var bedAdded = false
    @State private var foodAndDrinks = false
    
    var hasValidReservation: Bool {
        if startingPoint.isEmpty || destination.isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                
                ZStack {
                  /*  Image("trainBackground")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all) */
                    
                    LinearGradient(gradient:Gradient(colors: [.white, .black]) , startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        
        VStack {
           
            ZStack {
                if self.index == 0 {
                    VStack {
                        ZStack {
                            
                       Text("Welcome to Train ticket reservation shop")
                            
                            .font(.system(size: 50))
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                            
                        
                        }
                        
                        Button("Reserve new Ticket") {
                            
                            self.index = 1
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 55)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: .white, radius: 5)
                        .padding(20)
                        
                        NavigationLink{
                            MyTravellings()
                        } label: {
                            Text("My Tickets")
                        }
            
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 55)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: .white, radius: 5)
                        .padding(20)
                            
                        Button("See graphs") {
                            
                            showingGraphsheet.toggle()
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 55)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: .white, radius: 5)
                        .padding(20)
                        .sheet(isPresented: $showingGraphsheet) {
                            GraphView()
                        }
                    }
                            
                }
                else if self.index == 1 {
                    NavigationView {
                    VStack {
                        Form {
                            Section {
            TextField("Please enter starting point", text: $startingPoint )
            TextField("Please enter your destination", text: $destination)
            DatePicker("Date of aparture",
                       selection: $dateOfAparture, in: Date()..., displayedComponents: .date)
            
                            
                            } header: {
                                Text("Location and time")
                                
                            }
                            Section{
        Picker("Number of people", selection: $numberOfPeople) {
                                    ForEach(1..<6) {
                                        Text("\($0) people")
                                    }
                                }
                                Toggle("Any special request", isOn: $specialRequestEnabled.animation())
                                if specialRequestEnabled {
                                    Toggle("Coupe with bed", isOn: $bedAdded)
                                    Toggle("Food and drinks", isOn: $foodAndDrinks)
                                }
                                Text("Number of seats left:  \(String(numberOfSeatsLeft))")
                    
                                
                            } header: {
                                Text("Informations")
                            }
                            Section  {
                                
                                VStack {
                                Button(action: {
                                    
                                    let reservation = Reservation(context: moc)
                                    
                                    reservation.id = UUID()
                                    reservation.startingPoint = startingPoint
                                    reservation.destination = destination
                                    reservation.numberOfPeople = Int16(numberOfPeople)
                                    dateOfAparture = Date.now
                                    reservation.dateOfAparture = dateOfAparture
                                    
                                    
                                   try? moc.save()
                                   
                                    
                                    startingPoint = ""
                                    destination = ""
                                    
                                  numberOfSeatsLeft -=  numberOfPeople + 1
                                    
                                }) {
                                    
                                    Text("Add reservation")
                                }
                                    
                                    NavigationLink {
                                        CheckOutView()
                                    }label: {
                                        Text("")
                                    }
                                    
                                }
                  
                            
                            }
                            .disabled(hasValidReservation == false || hasSeats == false)
                        }
                    }
                    .navigationTitle("Reservations")
                        
                    }
                }
                else {
                    
                    VStack {
                        Text("See you next time").foregroundColor(.white)
                        Button("Exit")
                        {
                            exit(0)
                        }
                        
                    }
                }
            }
            
            
        
            Spacer()
           CustomTabBar(index: $index)
        }
                }
            }
        
        }
        
        
    }
        
}

struct MainView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        MainView()
    }
}


/* .toolbar{
 ToolbarItem(placement: .navigationBarTrailing) {
     Button {
         //ne radi jos nista
     } label: {
         Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
         
     }
 }
 
}*/



/*        Button("Add Reservation") {
    let reservation = Reservation(context: moc)
    
    reservation.id = UUID()
    reservation.startingPoint = startingPoint
    reservation.destination = destination
    reservation.numberOfPeople = Int16(numberOfPeople)
    reservation.dateOfAparture = dateOfAparture
    
   try? moc.save()
    
}

*/
