//
//  CustomTabBar.swift
//  TrainTracker
//
//  Created by COBE on 16.09.2022..
//

import SwiftUI


struct CustomTabBar: View {
    @Binding var index: Int
    var body: some View {
        HStack(spacing: 15) {
            HStack {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                Text(self.index == 0 ? "Home" : "")
                    .fontWeight(.light)
                    .font(.system(size: 14))
            }
            .padding()
            .background(self.index == 0 ? Color.darkBackground.opacity(0.4) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 0
            }
            
            HStack {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                
                Text(self.index == 1 ? "Ticket" : "")
                    .fontWeight(.light)
                    .font(.system(size: 14))
            }
            .padding()
            .background(self.index == 1 ? Color.darkBackground.opacity(0.4) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 1
            }
            
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                Text(self.index == 2 ? "Sign Out" : "")
                    .fontWeight(.light)
                    .font(.system(size: 14))
            }
            .padding()
            .background(self.index == 2 ? Color.darkBackground.opacity(0.4) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 2
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .animation(.default)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(index: .constant(1))
    }
}
