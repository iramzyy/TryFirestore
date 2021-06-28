//
//  FirestoreManager.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreManager {
    
    private init() {}
    
    static let shared = FirestoreManager()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collectionReference: FirestoreReferences) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func create<T: Codable>(for encodableObject: T, in collectionReference: FirestoreReferences) {
        do {
            let json = try encodableObject.convertToJSON(excluding: ["id"])
            reference(to: .tasks).addDocument(data: json) { error in
                if error != nil {
                    print(error.debugDescription)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func read<T: Codable>(from collectionReference: FirestoreReferences, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
        reference(to: .tasks).addSnapshotListener(includeMetadataChanges: false) { (snapshot, error) in
            if error == nil {
                guard let snapshot = snapshot else {return}
                do {
                    var objects = [T]()
                    for document in snapshot.documents {
                        let object = try document.decode(as: objectType.self)
                        objects.append(object)
                    }
                    completion(objects)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func update<T: Encodable & Identifiable>(for encodableObject: T, in collectionReference: FirestoreReferences) {
        do {
            let json = try encodableObject.convertToJSON(excluding: ["id"])
            guard let id = encodableObject.id else { throw TryFirestoreErrors.encodingError }
            reference(to: .tasks).document(id).setData(json)
        } catch {
            print(error)
        }
    }
    
    
    func delete<T: Identifiable>(_ identifiableObject: T,  in collectionReference: FirestoreReferences) {
        do {
            guard let id = identifiableObject.id else {throw TryFirestoreErrors.encodingError}
            reference(to: .tasks).document(id).delete { error in
                if error != nil {
                    print(error.debugDescription)
                }
            }
        } catch {
            print(error)
        }
    }
}
