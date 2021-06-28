//
//  Encodable+Extension.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import Foundation

enum TryFirestoreErrors: Error {
    case encodingError
}

extension Encodable {
    func convertToJSON(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else {
            throw TryFirestoreErrors.encodingError
        }

        for key in keys {
            json[key] = nil
        }
        return json
    }
}
