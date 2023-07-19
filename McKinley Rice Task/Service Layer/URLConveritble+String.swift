//
//  URLConveritble+String.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

protocol URLConvertible {
    
    func asURL() throws -> URL
}

extension String: URLConvertible {
    
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw  MRError.invalidURL(url: self) }
        return url
    }
}
