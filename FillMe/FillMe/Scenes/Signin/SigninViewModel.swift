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

final class SigninViewModel {
    
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
                    // error 처리하기
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { uid in
                userUID = uid
            }
            .store(in: &cancellables)

    }
    
    private func registerUserInfo(id: String, documentData: MetaData) {
        var success: Bool = false
        
        usecase.saveUserInfo(id: id, info: documentData)
            .sink { _ in
                // print보다는 좀 더 의미있는 액션을...
                print("Register status: \(success)")
            } receiveValue: { result in
                success = result
            }
            .store(in: &cancellables)
    }
    
    private func createUserMetaData(uid: String, email: String) -> MetaData {
        return ["uid": uid,
                "name": email,
                "email": email]
    }
    
}
