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
            if let error = error {
                completion(.failure(.underlyingError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.hasStatusCode else {
                completion(.failure(.invalidReponse))
                return
            }
            
            guard let unwrappedData = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(unwrappedData))
        }
        task.resume()
    }
}
