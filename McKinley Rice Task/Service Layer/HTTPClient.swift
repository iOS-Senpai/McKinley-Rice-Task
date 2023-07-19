//
//  HTTPClient.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

protocol HTTPClient {
    
    typealias MRResult = (Result<Data, MRError>) -> Void
    static func request(with url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping MRResult)
    
}
