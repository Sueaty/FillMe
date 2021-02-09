//
//  DiaryUseCase.swift
//  FillMe
//
//  Created by Sue Cho on 2021/02/09.
//

import Foundation
import Combine
import Firebase

protocol DiaryUseCaseType {
    // Saves diary in Firestore
    func save(diary: Diary) -> AnyPublisher<Bool, Error>
}

class DiaryUseCase {
    
    private let networkService: NetworkServiceType
    private var cancellables = [AnyCancellable]()
    private var id = Auth.auth().currentUser?.uid
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
}

// MARK:- Methods of DiaryUseCaseType
extension DiaryUseCase: DiaryUseCaseType {
    
    func save(diary: Diary) -> AnyPublisher<Bool, Error> {
        // id를 user default에 넣을까... 로그아웃하고 쓰는 경우가 드물겠지만 그건 바꿔주면 되니까. 일단 계속 불러오는걸로.

        let metadata: MetaData = diaryToMetaData(diary: diary)
        
        return Future<Bool, Error> { [weak self] promise in
            guard let self = self,
                  let id = self.id else { return }
            self.networkService.saveDocument(collectionPath: "Diaries/2021-02-09/Users",
                                        documentPath: id,
                                        data: metadata)
                .sink { result in
                    switch result {
                    case .finished:
                        promise(.success(true))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { success in
                    print("Diary saved")
                }
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }
    
}

// MARK:- Private Methods
extension DiaryUseCase {
    
    private func diaryToMetaData(diary: Diary) -> [String: Any] {
        return ["date": diary.date,
                "title": diary.title,
                "content": diary.content,
                "share": diary.share]
    }
    
}
