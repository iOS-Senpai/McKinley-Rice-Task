//
//  HTTPResponse+StatusCode.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

extension HTTPURLResponse {
    
    var hasStatusCode: Bool {
        print(statusCode)
        return (200..<299).contains(statusCode)
    }
}
