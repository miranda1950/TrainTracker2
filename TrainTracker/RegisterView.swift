//
//  RegisterView.swift
//  TrainTracker
//
//  Created by COBE on 13.09.2022..
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var statusMessage = ""
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var age = 18
    @State private var number = ""
    @State private var address = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                
            Form {
                Section {
                    TextField("Please Enter your first name",text: $firstName)
                    TextField("Please enter your last name",text: $lastName)
                    TextField("Please enter your email",text: $email)
                        .autocapitalization(.none)
                    SecureField("Please enter your password", text: $password)
                    
                } header: {
                    Text("Personal information")
                }
                
                
                    Picker("Age", selection: $age) {
                        ForEach(18..<100) {
                            Text("\($0) years")
                        }
                    }
                    TextField("Enter your number", text: $number)
                        .keyboardType(.numberPad)
                    
                    TextField("Enter your address",text: $address)
                        
                Text(statusMessage.self)
                    
            
                
            }
                
                VStack {
                    
                    Button(action: {
                        
                        handleAction()
                        
                    }, label: {
                       Text("Register")
                            
                            .font(.headline)
                            .foregroundColor(.darkBackground)
                            .frame(width: 220, height: 55)
                            .background(.blue)
                            .cornerRadius(20)
                            .shadow(color: .darkBackground, radius: 5)
                    })
                    
                }
                
            }
            
                .navigationTitle("Register")
        }
    }
    private func handleAction() {
        createNewAccount()
    }
    
   private func createNewAccount() {
Auth.auth().createUser(withEmail: email,password: password) {
    result, err in
    
    if let err = err {
        print("Failed to create user", err)
        self.statusMessage = "Failed to create user: \(err)"
        return
    }
    print("Successfully created user: \(result?.user.uid ?? "")")
    
    self.statusMessage = "Successfully created user: \(result?.user.uid ?? "")"

    self.storeUserInfo()
    
    dismiss()
    
}
    }
    
    private func storeUserInfo() {
        guard  let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["fname": self.firstName, "lname": self.lastName, "email": self.email, "age": String(self.age), "number": self.number, "address": self.number, "password": self.password]
        
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.statusMessage = "\(err)"
                    return
                }
                print("Success")
            }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
