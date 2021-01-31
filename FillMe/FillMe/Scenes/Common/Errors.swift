//
//  Errors.swift
//  FillMe
//
//  Created by Sue Cho on 2021/01/29.
//

import Foundation

// Network Service Error
enum NetworkServiceError: Error {
    case firestoreError(error: Error)
    case nonExistingSnapshot
    case nonExistingDocument
}

// Usecase Error
enum UseCaseError: Error {
    case networkError
    case typeConversionError
    case unknownError
}
