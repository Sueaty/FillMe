//
//  SigninUseCase.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/31.
//

import Foundation
import Firebase
import Combine

protocol SigninUseCaseType: class {
    // creates a new user account and returns user's UID
    func createAccount(email: String, password: String) -> AnyPublisher<String, Error>
    // saves user information in Firestore
    func saveUserInfo(id: String, info: MetaData) -> AnyPublisher<Bool, UseCaseError>
}

final class SigninUseCase {
    
    private let networkService: NetworkServiceType
    private var cancellables = [AnyCancellable]()
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
}

extension SigninUseCase: SigninUseCaseType {
    
    func createAccount(email: String, password: String) -> AnyPublisher<String, Error> {
        return Future<String, Error> { promise in
            Auth.auth().createUser(withEmail: email,
                                   password: password) { (authResult, error) in
                // 더 자세히 써야함
                if let error = error {
                    promise(.failure(error))
                } else {
                    if let authResult = authResult {
                        promise(.success(authResult.user.uid))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveUserInfo(id: String, info: MetaData) -> AnyPublisher<Bool, UseCaseError> {
        let collectionPath = "Users"
        return Future<Bool, UseCaseError> { [weak self] promise in
            guard let self = self else { return }
            self.networkService.saveDocument(
                collectionPath: collectionPath,
                documentPath: id,
                data: info)
                .sink { result in
                    switch result {
                    case .finished:
                        promise(.success(true))
                    case .failure(_):
                        promise(.failure(.networkError))
                    }
                } receiveValue: { success in
                    if success {
                        print("User Info Saved Successfully")
                    }
                }
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }
    
}
