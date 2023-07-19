//
//  HomeViewModel.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var users = [UserDetail]()
    @Published var name: String = ""
    @Published var job: String = ""
    
    func fetchUserDetail() {
        Session.request(with: "https://reqres.in/api/users", method: .get) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    let user = data.decode(of: User.self)
                    self.users = user?.data ?? []
                case let .failure(error):
                    print("Error thrown: \(error)")
                }
            }
        }
    }
    
    func createUser(completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = [
            "name": name,
            "job": job
        ]
        Session.request(with: "https://reqres.in/api/users", method: .post, parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    guard let newUser = data.decode(of: CreateUserModel.self) else { return }
                    print(newUser)
                    let temp = UserDetail(id: newUser.id.asInt() ?? 0, email: "", firstName: newUser.name, lastName: newUser.job, avatar: "")
                    self.users += CollectionOfOne(temp)
                    completion(true)
                case let .failure(error):
                    print("Error thrown: \(error)")
                    completion(false)
                }
            }
        }
    }
}

extension String {
    
    func asInt() -> Int? {
        return Int(self) ?? 0
    }
}
