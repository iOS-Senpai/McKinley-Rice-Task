//
//  Data+Serialization.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/18.
//

import Foundation

protocol DataSerializable {
    associatedtype SerializedObject
    func serialize(data: Data) throws -> SerializedObject
}

final class DecodableSerializer<T: Decodable>: DataSerializable {
    
    func serialize(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw MRError.decodingFailed(reason: error)
        }
    }
}

extension Data {
    
    func decode<T: Decodable>(of type: T.Type) -> T? {
       return try? DecodableSerializer<T>().serialize(data: self)
    }
}
