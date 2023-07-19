//
//  HTTPHeaders.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

struct HTTPHeader {
    let name: String
    let value: String
}

struct HTTPHeaders {
    
    private let headers: [HTTPHeader]
    
    init(_ headers: [HTTPHeader]) {
        self.headers = headers
    }
    
    var dictionary: [String: String]? {
        let namesAndValues = headers.map { ($0.name, $0.value) }
        return Dictionary(namesAndValues) { _, last in last }
    }
}
