//
//  AppError.swift
//  News
//
//  Created by Wilson Mungai on 2023-02-25.
//

import Foundation

// describes the errors that might occur
enum AppError: LocalizedError {
    case failedToGetData
    
    var errorDescription: String? {
        switch self {
        case .failedToGetData:
            return "The data couldn't be fetched"
        }
    }
}


