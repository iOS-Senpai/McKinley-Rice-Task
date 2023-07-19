//
//  SignupViewModel.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/18.
//

import SwiftUI

final class SignupViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var hasSignupError = false
    
    enum State {
        case didReceiveData(_ value: String)
        case none
    }
    
    @Published var state: State = .none
    
    func signUp(completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Session.request(with: "https://reqres.in/api/register", method: .post, parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    guard let signup = data.decode(of: SignupModel.self) else { return }
                    if signup.token == nil {
                        self.hasSignupError = true
                        self.state = .didReceiveData(signup.error ?? "")
                    } else {
                        completion(true)
                    }
                case let .failure(error):
                    print(error)
                    self.hasSignupError = true
                    completion(false)
                }
            }
        }
    }
}
