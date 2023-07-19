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
                    completion(!signup.token.isEmpty)
                case let .failure(error):
                    self.hasSignupError = true
                    completion(false)
                }
            }
        }
    }
    
}
