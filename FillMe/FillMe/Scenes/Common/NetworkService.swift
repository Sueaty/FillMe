//
//  NetworkService.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/29.
//

import Foundation
import Combine
import FirebaseFirestore

typealias MetaData = [String: Any]

protocol NetworkServiceType {
    // fetch necessary document from given document reference
    func fetchDocument(docRef: DocumentReference) -> AnyPublisher<MetaData, NetworkServiceError>
    // save necessary document to given document reference
    func saveDocument(docRef: DocumentReference, data: MetaData) //-> AnyPublisher<Bool, NetworkServiceError>
}

final class NetworkService: NetworkServiceType {
    
    func fetchDocument(docRef: DocumentReference) -> AnyPublisher<MetaData, NetworkServiceError> {
        let reference: DocumentReference = docRef
        return Future<MetaData, NetworkServiceError> { promise in
            reference.getDocument { (snapshot, error) in
                if let error = error {
                    promise(.failure(.firestoreError(error: error)))
                }
                guard let snapshot = snapshot,
                      snapshot.exists else {
                    return promise(.failure(.nonExistingSnapshot))
                }
                guard let metadata = snapshot.data() else {
                    return promise(.failure(.nonExistingDocument))
                }
                promise(.success(metadata))
            }
        }
        //.receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func saveDocument(docRef: DocumentReference, data toSave: MetaData) { //-> AnyPublisher<Bool, NetworkServiceError>
        let reference: DocumentReference = docRef
        reference.setData(toSave)
//        return Future<Bool, NetworkServiceError> { promise in
//            reference.setData(toSave)
//        }
    }
    
}
