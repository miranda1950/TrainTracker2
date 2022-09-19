//
//  CheckOutView.swift
//  TrainTracker
//
//  Created by COBE on 18.09.2022..
//

import SwiftUI

struct CheckOutView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var reservations: FetchedResults<Reservation>

    
 //   let reservation: Reservation
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://static.euronews.com/articles/stories/06/58/44/14/1440x810_cmsv2_e6a71e52-73ca-5b71-83d3-b630a0fdd418-6584414.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame( height: 233)
                VStack {
              Text("You have made a train seat reservation")
                Text("Charging will be proceeded in train")
            Text("Train tracker wish you a nice trip 😁🚄")
                }
                .frame(width: 400, height: 150)
                .font(.headline)
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(Capsule())
                }
            
                }
            }
        }

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}
    




