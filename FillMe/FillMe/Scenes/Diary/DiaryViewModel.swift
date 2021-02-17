//
//  DiaryViewModel.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/29.
//

import Foundation
import Firebase
import Combine

final class DiaryViewModel {
    
    private var usecase: DiaryUseCaseType
    private var cancellables = [AnyCancellable]()
    
    init(usecase: DiaryUseCaseType = DiaryUseCase()) {
        self.usecase = usecase
    }
    
    func saveDiary(diary: Diary) {
        usecase.save(diary: diary)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished")
                case .failure(_):
                    print("Failed")
                }
            } receiveValue: { success in
                print("Saved diary:\(success)")
            }
            .store(in: &cancellables)

    }
    
}
