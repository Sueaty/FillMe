//
//  SigninViewModel.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/31.
//

import Foundation
import FirebaseFirestore
import Firebase
import Combine

class SigninViewModel {
    
    private var usecase: SigninUseCaseType
    private var cancellables = [AnyCancellable]()
    
    init(usecase: SigninUseCaseType = SigninUseCase()) {
        self.usecase = usecase
    }
    
    func createAccount(email: String, password: String) {
        var userUID: String = ""
        
        usecase.createAccount(email: email, password: password)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    guard let self = self else { return }
                    let documentData = self.createUserMetaData(uid: userUID, email: email)
                    self.registerUserInfo(id: userUID, documentData: documentData)
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { uid in
                print("Account creation uid: \(uid)")
                userUID = uid
            }
            .store(in: &cancellables)

    }
    
    private func registerUserInfo(id: String, documentData: MetaData) {
        Firestore.firestore()
            .collection("Users")
            .document(id)
            .setData(documentData) { error in
                if let error = error { print(error) }
                else {
                    print("Registered!")
                }
            }
    }
    
    private func createUserMetaData(uid: String, email: String) -> MetaData {
        return ["uid": uid,
                "name": email,
                "email": email]
    }
    
}
