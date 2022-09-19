//
//  ContentView.swift
//  TrainTracker
//
//  Created by COBE on 13.09.2022..
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    
    
    @State private var email = ""
    @State private var password = ""
    @State var statusMessage = ""
    @State private var loginIncorrectAlert: Bool = false
    
   @Binding var isUserCurrentlyLoggedOut: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("TrainTracker")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 40)
                
                Image("train")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)
                
                VStack {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .foregroundColor(.darkBackground)
                        .padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        
                        
                    SecureField("Password", text: $password)
                        .foregroundColor(.darkBackground)
                        .padding()
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        
                        
                    Button(action: {
                        loginUser()
                    }, label: {
                       Text("Sign in")
                            
                            .font(.headline)
                            .foregroundColor(.darkBackground)
                            .frame(width: 220, height: 55)
                            .background(.blue)
                            .cornerRadius(20)
                            .shadow(color: .darkBackground, radius: 5)
                    })
                    .alert( isPresented: $loginIncorrectAlert) {
                        Alert(title: Text("Email/password incorrect"))
                       
                    }
                    .padding()
                    
                    VStack {
                        Text("Don't have an account?")
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Register")
                                .foregroundColor(.blue)
                            
                        }
                        Text(self.statusMessage)
                            .foregroundColor(.black)
                }
                
                Spacer()
            }
                
            
                .padding()
            
        }
        
    }
        
    
    }
   private func loginUser() {
       Auth.auth().signIn(withEmail: email, password: password) {
           result, err in
           if let err = err {
               print("Failed to login", err)
               self.statusMessage = "Failed to login user: \(err)"
               self.loginIncorrectAlert = true
               return
           }
           print("Sucessfully logged in as user:\(result?.user.uid ?? "")")
  
           self.statusMessage = "Sucessfully logged in as user: \(result?.user.uid ?? "")"
           
           
           
          self.isUserCurrentlyLoggedOut = true
       }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        ContentView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}


