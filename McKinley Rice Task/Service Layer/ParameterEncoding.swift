//
//  ParameterEncoding.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/18.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

struct JSONEncoding: ParameterEncoding {
    
    enum Error: Swift.Error {
        case invalidJsonObject
    }
    
    static var current: JSONEncoding { JSONEncoding() }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let parameters = parameters else { return request }
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw MRError.paramterEncodingFailed(reason: .jsonEncodingFailed(error: Error.invalidJsonObject))
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters)
            if request.allHTTPHeaderFields?["Content-Type"] == nil {
                request.allHTTPHeaderFields?.updateValue("application/json", forKey: "Content-Type")
            }
            request.httpBody = data
        } catch {
            throw MRError.paramterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        return request
    }
}

struct URLEncoding: ParameterEncoding {
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        var requestURL: URL!
        guard let url = request.url, let parameters = parameters else {
            return request
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            for(key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            requestURL = urlComponents.url
        }
        
        if(request.value(forHTTPHeaderField: "Content-Type") == nil) {
            request.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return URLRequest(url: requestURL)
    }
}
