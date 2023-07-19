//
//  LoginModel.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

struct LoginModel: Decodable {
    let token: String?
    let error: String?
}
