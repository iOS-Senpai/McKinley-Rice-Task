//
//  MRError.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

enum MRError: Error {
    
    enum ParamterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
    }
    
    case invalidURL(url: URLConvertible)
    case paramterEncodingFailed(reason: ParamterEncodingFailureReason)
    case decodingFailed(reason: Error)
    case underlyingError(_ error: Error)
    case invalidReponse
    case invalidData
    case badRequest
}
