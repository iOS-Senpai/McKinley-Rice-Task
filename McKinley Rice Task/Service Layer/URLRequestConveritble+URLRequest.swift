//
//  URLRequestConveritble+URLRequest.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

protocol URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest
}

extension URLRequest: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        return self
    }
}

extension URLRequest {
    
    init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers?.dictionary
    }
}

struct RequestConvertible: URLRequestConvertible {
    
    let url: URLConvertible
    let method: HTTPMethod
    let parameters: Parameters?
    let encoding: ParameterEncoding = JSONEncoding.current
    let headers: HTTPHeaders?
    
    func asURLRequest() throws -> URLRequest {
        let urlrequest = try URLRequest(url: url, method: method, headers: headers)
        return try encoding.encode(urlrequest, with: parameters)
    }
}
