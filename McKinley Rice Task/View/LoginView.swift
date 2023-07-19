//
//  LoginView.swift
//  McKinley Rice Task
//
//  Created by AB020QU on 2023/07/19.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var vm = LoginViewModel()
    @State private var showSignup = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
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
                            vm.login()
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        .navigationDestination(isPresented: $vm.isLoginSuccessful, destination: {
                            HomeView()
                        })
                        .alert("Error", isPresented: $vm.hasLoginError, presenting: vm.state, actions: { result in
                          
                                Button("Ok", role: .cancel) { }
                        }, message: { result in
                            if case let .failure(error) = result {
                                Text(error.description)
                            }
                        })
                        .animation(.easeIn(duration: 0.3), value: vm.isLoginSuccessful)
                        .padding()
                    }
                }
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .overlay(alignment: .bottom) {
                HStack {
                    Text("New User? ")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    
                    Button {
                        withAnimation {
                            self.showSignup = true
                        }
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                    .navigationDestination(isPresented: $showSignup) {
                        SignupView(showSignup: $showSignup)
                    }
                    .animation(.easeIn(duration: 0.3), value: showSignup)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
