//
//  SFSymbols.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/19.
//

import Foundation

enum SFSymbols {
    
    static let phone = "phone"
    static let chatBubble = "bubble.left"
}

extension String {
    
    static var phonel: Self {
        return SFSymbols.phone
    }
}


