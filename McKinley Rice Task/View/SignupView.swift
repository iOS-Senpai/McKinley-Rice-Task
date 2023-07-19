//
//  SignupView.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var vm = SignupViewModel()
    @Binding var showSignup: Bool
    @State private var showRegistrationSuccess = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Sign UP")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Username")
                    .foregroundColor(.gray)
                    .font(.callout)
                    .padding()
                
                TextField("Please enter username", text: $vm.username)
                    .padding(.horizontal, 16)
                    .textFieldStyle(.roundedBorder)
                
                Text("Email")
                    .foregroundColor(.gray)
                    .font(.callout)
                    .padding()
                
                TextField("Please enter email", text: $vm.email)
                    .padding(.horizontal, 16)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                
                Text("Password")
                    .foregroundColor(.gray)
                    .font(.callout)
                    .padding()
                
                SecureField("Please enter password", text: $vm.password)
                    .padding(.horizontal, 16)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Button(action: {
                        vm.signUp { flag in
                            withAnimation {
                                self.showRegistrationSuccess = flag == true
                            }
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    .alert("Message", isPresented: $showRegistrationSuccess, actions: {
                        Button("OK", role: .cancel) {
                            withAnimation {
                                self.showSignup = false
                            }
                        }
                    }, message: {
                        Text("Registration successful....!")
                    })
                    .alert("Error", isPresented: $vm.hasSignupError, presenting: vm.state,actions: { result in
                        
                        Button("Ok", role: .cancel) { }
                    }, message: { result in
                        if case let .didReceiveData(value) = result {
                            Text(value)
                        } else {
                            Text("Resgistration unsuccssful....")
                        }
                    })
                    .animation(.easeIn(duration: 0.3), value: showSignup)
                    .padding()
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .overlay(alignment: .bottom) {
            HStack {
                Text("Already having an account? ")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                
                Button {
                    withAnimation {
                        self.showSignup = false
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .animation(.easeIn(duration: 0.3), value: showSignup)
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(showSignup: .constant(false))
    }
}
