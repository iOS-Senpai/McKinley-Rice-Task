//
//  Error+String.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

extension Error {
    
    var description: String {
        guard self is MRError else { return "Our best minds are working on it." }
        return "\(self)"
    }
}
