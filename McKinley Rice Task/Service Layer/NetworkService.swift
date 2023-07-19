//
//  NetworkService.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/18.
//

import Foundation

struct Session: HTTPClient {
    
    static func request(with url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping MRResult) {
        let requestConvertible = RequestConvertible(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers)
        perform(requestConvertible, completion: completion)
    }
    
    private static func perform(_ request: URLRequestConvertible, completion: @escaping MRResult) {
        guard let request = try? request.asURLRequest() else {
            completion(.failure(.badRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let mrError = error.map { MRError.underlyingError($0) }
            let transformedResult = Result(success: data, failure: mrError)
            completion(transformedResult)
        }
        task.resume()
    }
}

// Code cleanup

extension Result {
    
    init(success: Success?, failure: Failure?) {
        if let value = success {
            self = .success(value)
        } else if let error = failure {
            self = .failure(error)
        } else {
            fatalError("Couldn't create result....")
        }
    }
}
