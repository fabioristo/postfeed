//
//  ErrorType.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 17/02/23.
//

import Foundation

enum ErrorType: Error {
    case badUrl
    case responseError
    case unauthorized
    
    var errorDescription: String {
        switch self {
        case .badUrl:
            return "Invalid URL"
        case .responseError:
            return "Invalid Response"
        case .unauthorized:
            return "Unauthorized"
        }
    }
}
