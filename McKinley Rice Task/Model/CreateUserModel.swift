//
//  CreateUserModel.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

struct CreateUserModel: Decodable {
    var name: String
    var job: String
    var id: String
    var createdAt: String
}
