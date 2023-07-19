//
//  LoginViewModel.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginSuccessful = false
    @Published var hasLoginError = false
    
    enum State {
        case failure(_ error: Error)
        case didReceiveData(_ value: String)
        case none
    }
    
    @Published var state: State = .none
    @AppStorage(StorageKeys.TOKEN) private var saveToken: String = ""
    
    func login() {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Session.request(with: "https://reqres.in/api/login", method: .post, parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    let login = data.decode(of: LoginModel.self)
                    guard let login = login else { return }
                    if login.token == nil {
                        self.hasLoginError = true
                        self.state = .didReceiveData(login.error ?? "")
                    } else {
                        self.saveToken = login.token ?? ""
                        self.isLoginSuccessful = true
                    }
                case let .failure(error):
                    self.hasLoginError = true
                    self.state = .failure(error)
                }
            }
        }
    }
}

//https://reqres.in/api/login POST
//https://reqres.in/api/register POST
//https://reqres.in/api/users?page=1 GET
//https://reqres.in/api/users POST
