//
//  Snapshot+Extension.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        var documentJSON = data()
        if includingId {
            documentJSON!["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJSON, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}
